import 'package:flutter/material.dart';
import 'package:toot_mart/core/widgets/custom_drop_down.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utiles/size_config.dart';
import 'componnent/body.dart';

class ExhibitionsScreen extends StatelessWidget {
  const ExhibitionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: customAppbar(
        title: translateString("Exhibition sites", "مواقع المعارض"),
        context: context,
        press: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth! * 0.03,
            vertical: SizeConfig.screenHeight! * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              translateString("Show gallery from", "اظهار المعرض من"),
              style: headingStyle.copyWith(
                  color: colordeepGrey,
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.screenWidth! * 0.045),
            ),
            const VerticalSpace(value: 1.5),
            CustomDropDown(
              text: translateString("All Area", "جميع المناطق"),
              items: [],
            ),
            const VerticalSpace(value: 1.5),
            const GalleryListData(),
          ],
        ),
      ),
    );
  }
}
