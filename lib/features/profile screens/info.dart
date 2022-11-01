import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';

import '../../core/utiles/size_config.dart';

class InformationScreen extends StatefulWidget {
  final String title;
  final String body;
  const InformationScreen({Key? key, required this.title, required this.body}) : super(key: key);

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: customAppbar(
        title: widget.title,
        context: context,
        press: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth! * 0.03,
            vertical: SizeConfig.screenHeight! * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                kLogo,
                color: kMainColor,
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            const VerticalSpace(value: 3),
            HtmlWidget(widget.body),
          
          ],
        ),
      ),
    );
  }
}
