// ignore_for_file: use_key_in_widget_constructors, unnecessary_null_comparison

import 'package:flutter/material.dart';


typedef RatingChangeCallback = void Function(double rating);

class CustomStarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  final Color? ratingColor;
  final Color? barColor;
  final double? size;

  const CustomStarRating(
      {this.starCount = 5,
      this.rating = .0,
      required this.onRatingChanged,
      this.size,
      this.ratingColor,
      this.barColor});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star_border,
        color: barColor ?? Colors.white,
        size: size,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        color: ratingColor ?? Theme.of(context).primaryColor,
        size: size,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: ratingColor ?? Theme.of(context).primaryColor,
        size: size,
      );
    }
    return InkResponse(
      onTap:
          onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        children:
            List.generate(starCount, (index) => buildStar(context, index)));
  }
}
