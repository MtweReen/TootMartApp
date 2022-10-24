import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:toot_mart/core/constants/colors.dart';

import '../../../core/constants/constants.dart';

class HomeSlider extends StatefulWidget {
  final List<String> images;
  final VoidCallback? press;
  const HomeSlider({Key? key, required this.images, this.press})
      : super(key: key);

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
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
          return customCachedNetworkImage(
            fit: BoxFit.fitHeight,
            context: context,
            url: widget.images[i],
          );
        },
        itemCount: widget.images.length,
        autoplay: true,
        autoplayDelay: 5000,
      ),
    );
  }
}
