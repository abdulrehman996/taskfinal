import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../utility/colors.dart';

class SellersShopCard extends StatefulWidget {
  final int id;
  final String image;
  final String name;
  final double stars;

  SellersShopCard(
      {Key? key,
      required this.id,
      required this.image,
      required this.name,
      required this.stars})
      : super(key: key);

  @override
  _SellersShopCardState createState() => _SellersShopCardState();
}

class _SellersShopCardState extends State<SellersShopCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.08),
              blurRadius: 20,
              spreadRadius: 0.0,
              offset: Offset(0.0, 10.0), // shadow direction: bottom right
            )
          ],
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  width: double.infinity,
                  height: 100,
                  child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16), bottom: Radius.zero),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/placeholder.png',
                        image: widget.image,
                        fit: BoxFit.scaleDown,
                      ))),
              Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Text(
                    widget.name,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        color: MyColor.dark_font_grey,
                        fontSize: 13,
                        height: 1.6,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: 15,
                  child: RatingBar(
                      ignoreGestures: true,
                      initialRating: widget.stars,
                      maxRating: 5,
                      direction: Axis.horizontal,
                      itemSize: 15.0,
                      itemCount: 5,
                      ratingWidget: RatingWidget(
                        full: Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        half: Icon(Icons.star_half),
                        empty: Icon(Icons.star,
                            color: Color.fromRGBO(224, 224, 225, 1)),
                      ),
                      onRatingUpdate: (newValue) {}),
                ),
              ),
              Container(
                  height: 23,
                  width: 103,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.amber),
                      color: MyColor.amber,
                      borderRadius: BorderRadius.circular(6)),
                  child: Text(
                    "Visit Store",
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.amber.shade700,
                        fontWeight: FontWeight.w500),
                  ))
            ]),
      ),
    );
  }
}
