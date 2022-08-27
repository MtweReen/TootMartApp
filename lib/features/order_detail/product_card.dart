import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';

class OrderCardItem extends StatefulWidget {
  final String image;
  final String name;
  final String price;
  final String quantity;
  const OrderCardItem(
      {Key? key,
      required this.image,
      required this.name,
      required this.price,
      required this.quantity})
      : super(key: key);

  @override
  State<OrderCardItem> createState() => _OrderCardItemState();
}

class _OrderCardItemState extends State<OrderCardItem> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.screenHeight! * 0.02,
          horizontal: SizeConfig.screenWidth! * 0.02),
      decoration: BoxDecoration(
        border: Border.all(color: colorLightGrey),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: SizeConfig.screenWidth! *0.25 ,
            height: SizeConfig.screenHeight! * 0.2,
            child: customCachedNetworkImage(
              url: widget.image,
              context: context,
              fit: BoxFit.fitHeight,
            ),
          ),
          const HorizontalSpace(value: 2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: headingStyle,
                ),
                const VerticalSpace(value: 2),
                Text(
                  translateString("Quantity : ", "الكمية : ") + widget.quantity,
                  style: headingStyle,
                ),
                const VerticalSpace(value: 2),
                Text(
                  widget.price +" "+ translateString("R.S", "ر.س"),
                  style: headingStyle.copyWith(
                      color: kMainColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
