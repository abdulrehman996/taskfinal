import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RatingWidget extends StatefulWidget {
  const RatingWidget({Key? key}) : super(key: key);

  @override
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  double _rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rating:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _rating = 1.0;
                });
              },
              child: Icon(
                _rating >= 1.0 ? Icons.star : Icons.star_border,
                color: Theme.of(context).primaryColor,
                size: 36,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _rating = 2.0;
                });
              },
              child: Icon(
                _rating >= 2.0 ? Icons.star : Icons.star_border,
                color: Theme.of(context).primaryColor,
                size: 36,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _rating = 3.0;
                });
              },
              child: Icon(
                _rating >= 3.0 ? Icons.star : Icons.star_border,
                color: Theme.of(context).primaryColor,
                size: 36,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _rating = 4.0;
                });
              },
              child: Icon(
                _rating >= 4.0 ? Icons.star : Icons.star_border,
                color: Theme.of(context).primaryColor,
                size: 36,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _rating = 5.0;
                });
              },
              child: Icon(
                _rating >= 5.0 ? Icons.star : Icons.star_border,
                color: Theme.of(context).primaryColor,
                size: 36,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
