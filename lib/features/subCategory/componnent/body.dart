import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utiles/size_config.dart';

class SubCategoryBody extends StatefulWidget {
  const SubCategoryBody({Key? key}) : super(key: key);

  @override
  State<SubCategoryBody> createState() => _SubCategoryBodyState();
}

class _SubCategoryBodyState extends State<SubCategoryBody> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: SizeConfig.screenHeight! * 0.3,
                child: Image.network(
                  "https://img.freepik.com/free-vector/realistic-3d-store-interior_1284-12763.jpg?w=1380",
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth! * 0.03,
                  vertical: SizeConfig.screenHeight! * 0.03,
                ),
                child: Container(
                  width: double.infinity,
                  height: SizeConfig.screenHeight! * 0.3,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      end: Alignment.topCenter,
                      begin: Alignment.bottomCenter,
                      colors: [
                        Colors.black,
                        Colors.transparent,
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "ابهريهم بفازتك ",
                      textAlign: TextAlign.center,
                      style: headingStyle.copyWith(
                          fontSize: SizeConfig.screenWidth! * 0.05,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            // ..strokeWidth = 1
                            ..color = Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth! * 0.03,
                vertical: SizeConfig.screenHeight! * 0.03),
            child: Column(),
          ),
        ],
      ),
    );
  }
}
