import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utiles/size_config.dart';

class GalleryListData extends StatefulWidget {
  const GalleryListData({Key? key}) : super(key: key);

  @override
  State<GalleryListData> createState() => _GalleryListDataState();
}

class _GalleryListDataState extends State<GalleryListData> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemCount: 10,
      separatorBuilder: (context, index) => Divider(
        color: colorGrey,
      ),
      itemBuilder: (context, index) => InkWell(
        onTap: (){},
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth! * 0.02,
              vertical: SizeConfig.screenHeight! * 0.02),
          margin: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth! * 0.02,
              vertical: SizeConfig.screenHeight! * 0.02),
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
              "Alreyad",
                style: headingStyle.copyWith(
                    color: colordeepGrey,
                    fontWeight: FontWeight.w700,
                    fontSize: SizeConfig.screenWidth! * 0.045),
              ),
              Image.asset("asset/images/location.png", width: 25, height: 25,fit: BoxFit.contain,),
              ],
            ),
              const VerticalSpace(value: 0.5),
               Text(
             "السعودية , مكة, ش 118",
              style: headingStyle.copyWith(
                  color: colorGrey,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  fontSize: SizeConfig.screenWidth! * 0.04),
            ),

             const VerticalSpace(value: 0.5),
               Text(
             "ساعات العمل اليوم 11:00 صباحا - 12:00 مساء",
              style: headingStyle.copyWith(
                  color: colordeepGrey,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  fontSize: SizeConfig.screenWidth! * 0.04),
            ),
          ],
         ),     
        ),
      ),
    );
  }
}
