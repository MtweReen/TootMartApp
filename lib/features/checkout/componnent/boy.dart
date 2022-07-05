import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:toot_mart/core/constants/constants.dart';

class CheckoutBody extends StatefulWidget {
  const CheckoutBody({Key? key}) : super(key: key);

  @override
  State<CheckoutBody> createState() => _CheckoutBodyState();
}

class _CheckoutBodyState extends State<CheckoutBody> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TimelineTile(
          isLast: false,
          isFirst: true,
          alignment: TimelineAlign.start,
          axis: TimelineAxis.horizontal,
          lineXY: .3,
          afterLineStyle: LineStyle(color: Colors.grey),
          indicatorStyle: IndicatorStyle(
            width: 30,
            height: 30,
            indicator: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[100],
              ),
              child: Icon(
                Icons.check_circle,
                size: 30,
                color: Colors.grey[100],
              ),
            ),
            color: Colors.white,
          ),
          endChild: Text(
            "bbbbbbbb",
            style: headingStyle,
          ),
          hasIndicator: true,
        ),
      ],
    );
  }
}
