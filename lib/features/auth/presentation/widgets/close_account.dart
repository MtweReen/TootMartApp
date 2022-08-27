// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:toot_mart/core/utiles/size_config.dart';
// import 'package:toot_mart/core/widgets/custom_buttons_widget.dart';
// import 'package:toot_mart/core/widgets/custom_text_field.dart';
// import 'package:toot_mart/core/widgets/space_widget.dart';
// import 'package:toot_mart/translations/locale_keys.g.dart';
//
// class CloseAccount extends StatelessWidget {
//   const CloseAccount({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: CustomContainer(
//             child: Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Column(
//         children: [
//           // Header(text: LocaleKeys.close_account.tr(), withBackBtn: true),
//           const VerticalSpace(value: 2),
//           Text(LocaleKeys.alert.tr(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: SizeConfig.defaultSize!*3,color: Colors.red),),
//           const VerticalSpace(value: 2),
//           Text(
//               LocaleKeys.are_you_sure.tr()),
//           const VerticalSpace(value: 3),
//           CustomTextFormField(label: LocaleKeys.password.tr()),
//           const VerticalSpace(value: 2),
//           CustomGeneralButton(text: LocaleKeys.confirm.tr(), onTap: () {})
//         ],
//       ),
//     )));
//   }
// }
