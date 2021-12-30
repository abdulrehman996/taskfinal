import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerWidget extends StatefulWidget {
  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int yourActiveIndex = 0;

  final List _bannerImage = [];

  getBanner() {
    return _firestore
        .collection('banners')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _bannerImage.add(doc['image']);
        });
      });
    });
  }

  @override
  void initState() {
    getBanner();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider.builder(
            itemCount: _bannerImage.length,
            itemBuilder: (context, index, realIndex) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  _bannerImage[index],
                  fit: BoxFit.cover,
                ),
              );
            },
            options: CarouselOptions(
              aspectRatio: 338 / 140,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration:
              const Duration(milliseconds: 1000),
              autoPlayCurve: Curves.easeInExpo,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  yourActiveIndex = index;
                });
              },
            ),
          ),
          Center(child: buildDots()),
        ],
      ),
    );
  }
  Widget buildDots() {
    if (_bannerImage.isEmpty) {
      return const SizedBox.shrink(); // Return an empty widget if banner images are not available
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: AnimatedSmoothIndicator(
        activeIndex: yourActiveIndex,
        count: _bannerImage.length,
        effect: ScrollingDotsEffect(
          activeDotColor: Colors.white,
          activeStrokeWidth: 2.6,
          activeDotScale: 1.5,
          maxVisibleDots: 5,
          radius: 8,
          spacing: 8,
          dotHeight: 6,
          dotWidth: 6,
        ),
      ),
    );
  }
}
