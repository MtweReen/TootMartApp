
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/network/local/cache_helper.dart';
import '../../../../core/utiles/size_config.dart';
import '../../../../core/widgets/space_widget.dart';
import '../../../../translations/locale_keys.g.dart';

class PaymentType extends StatefulWidget {
  const PaymentType({Key? key}) : super(key: key);

  @override
  State<PaymentType> createState() => _PaymentTypeState();
}

class _PaymentTypeState extends State<PaymentType> {
  int x = prefs.getInt("payment_type")??0;
  List<String> images = ['visa.png', 'master_card.png', 'mada.png', 'stc.png'];

  @override
  Widget build(BuildContext context) {
    print(x);
    return Container(
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: SizeConfig.defaultSize! * 5,
                width: SizeConfig.defaultSize! * 20,
                child: SizedBox.shrink(
                  child: RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    activeColor: kMainColor,
                    title: Text(LocaleKeys.cash_on_delivery.tr()),
                    value: 0,
                    groupValue: x,
                    onChanged: (int? value) {
                      setState(() {
                        x = value!;
                        CasheHelper.saveData(key: 'payment_type', value: 1);
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Image.asset('asset/images/bank.png',
                      height: SizeConfig.defaultSize! * 4),
                ),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.defaultSize! * 5,
            width: SizeConfig.screenWidth,
            child: SizedBox.shrink(
              child: RadioListTile(
                contentPadding: EdgeInsets.zero,
                activeColor: kMainColor,
                title: Text(LocaleKeys.pay_online.tr()),
                value: 1,
                groupValue: x,
                onChanged: (int? value) {
                  setState(() {
                    x = value!;
                    CasheHelper.saveData(key: 'payment_type', value: 0);
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: SizeConfig.defaultSize! * 3,
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Image.asset(
                        'asset/images/${images[index]}',
                        height: SizeConfig.defaultSize! * 4,
                      ),
                  separatorBuilder: (context, index) =>
                      const HorizontalSpace(value: 1),
                  itemCount: images.length),
            ),
          ),
        ],
      ),
    );
  }
}
