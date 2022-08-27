import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:toot_mart/core/constants/colors.dart';

class CategorySlider extends StatefulWidget {
  const CategorySlider({Key? key}) : super(key: key);

  @override
  State<CategorySlider> createState() => _CategorySliderState();
}

class _CategorySliderState extends State<CategorySlider> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SizedBox(
      width: w,
      height: h * 0.3,
      child: Swiper(
        pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
                color: kMainColor.withOpacity(0.3), activeColor: kMainColor),
            alignment: Alignment.bottomCenter),
        itemBuilder: (BuildContext context, int i) {
          return InkWell(
            child: Image.network(
                "https://img.freepik.com/free-vector/set-creative-minimalist-hand-painted-illustrations_69626-86.jpg?w=1380",
                fit: BoxFit.cover),
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {},
          );
        },
        itemCount: 4,
        autoplay: true,
        autoplayDelay: 5000,
      ),
    );
  }
}
