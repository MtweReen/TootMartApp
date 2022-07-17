import 'package:flutter/material.dart';
import 'package:toot_mart/core/widgets/custom_buttons_widget.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/router/router.dart';
import '../../../../core/utiles/size_config.dart';
import '../../../../core/widgets/space_widget.dart';
import '../../../map/add_address.dart';

class AddLocationView extends StatelessWidget {
  const AddLocationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  'asset/images/location.png',
                  color: Colors.black,
                  height: SizeConfig.defaultSize! * 4,
                ),
                HorizontalSpace(value: 1),
                Text(
                  'تحديد العنوان',
                  style: headingStyle,
                ),
                Spacer(),
                IconButton(
                    icon: Image.asset(
                      'asset/images/plus.png',
                      height: SizeConfig.defaultSize! * 2.5,
                    ),
                    onPressed: () {
                      MagicRouter.navigateTo(const AddAddress());
                    }),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: colorLightGrey,
          ),
        ],
      ),
    );
  }
}
