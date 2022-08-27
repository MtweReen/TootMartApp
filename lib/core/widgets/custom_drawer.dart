import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import '../../translations/locale_keys.g.dart';
import '../constants/colors.dart';
import '../utiles/size_config.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(color: kMainColor),
          width: SizeConfig.defaultSize! * 100,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 const VerticalSpace(value: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SizedBox(
                        width: SizeConfig.defaultSize! * 20,
                        child: TextFormField(
                          showCursor: false,
                          onTap: () {
                            
                          },
                          decoration: InputDecoration(
                            hintText: LocaleKeys.search_for_products.tr(),
                            helperStyle:
                                TextStyle(color: Colors.white.withOpacity(0.5)),
                            prefixIcon:const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ),
                const  VerticalSpace(value: 5),
                 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
