import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Center(
          child: CircleAvatar(
            radius: w * 0.174,
            backgroundColor: colorLightGrey,
            child: CircleAvatar(
              radius: w * 0.17,
              backgroundColor: Colors.white,
              child: Center(
                child: Image.asset(
                  "asset/images/Group 77157.png",
                  color: colorLightGrey,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: w * 0.17, top: h * 0.07),
          child: Center(
            child: CircleAvatar(
              backgroundColor: colorLightGrey,
              radius: w * 0.05,
              child: const Center(
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
