import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:toot_mart/core/constants/colors.dart';

class HomeSlider extends StatefulWidget {
 final List<String> images ;
  const HomeSlider({Key? key,required this.images}) : super(key: key);

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
          return InkWell(
            child: Image.network(
               widget.images[i],
                fit: BoxFit.cover),
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            // overlayColor: ,
            onTap: () async {},
          );
        },
        itemCount: widget.images.length,
        autoplay: true,
        autoplayDelay: 5000,
      ),
    );
  }
}
