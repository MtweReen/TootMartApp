
import 'package:flutter/material.dart';
import 'package:toot_mart/features/auth/data/business_logic/auth_cubit.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utiles/size_config.dart';
import '../../../../core/widgets/custom_buttons_widget.dart';
import '../../../../core/widgets/profile_item.dart';

class GuestView extends StatelessWidget {
  const GuestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  translateString('Hello', 'مرحبا'),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.defaultSize! * 3),
                ),
                Icon(Icons.settings_outlined,
                    size: SizeConfig.defaultSize! * 4),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: SizeConfig.defaultSize! * 18,
                    child: CustomGeneralButton(
                        text: translateString('Log in', 'تسجيل الدخول'),
                        onTap: () {
                          AuthCubit.get(context).changeUserState(1) ;
                        })),
                Container(
                  width: SizeConfig.defaultSize! * 18,
                  child: CustomStrockButton(
                      text: translateString('Register', 'تسجيل'), onTap: () {}),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: h * 0.02, horizontal: w * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const InkWell(
                  child: ProfileCardItem(
                    title: 'تتبع الطلب',
                  ),
                ),
                SizedBox(
                  height: h * 0.04,
                ),
                const InkWell(
                  child: ProfileCardItem(
                    title: ' تواصل معنا',
                  ),
                ),
                SizedBox(
                  height: h * 0.04,
                ),
                const InkWell(
                  child: ProfileCardItem(
                    title: 'مواقع المعارض',
                  ),
                ),
                SizedBox(
                  height: h * 0.04,
                ),
                const InkWell(
                  child: ProfileCardItem(
                    title: 'التوصيل والمرتجعات',
                  ),
                ),
                SizedBox(
                  height: h * 0.04,
                ),
                const InkWell(
                  child: ProfileCardItem(
                    title: 'سياسة الخصوصية',
                  ),
                ),
                // SizedBox(
                //   height: h * 0.06,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
