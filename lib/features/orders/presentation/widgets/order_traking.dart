import 'package:flutter/material.dart';
import 'package:toot_mart/core/utiles/size_config.dart';

class OrderTraking extends StatefulWidget {
  const OrderTraking({Key? key}) : super(key: key);

  @override
  State<OrderTraking> createState() => _OrderTrakingState();
}

class _OrderTrakingState extends State<OrderTraking> {
  var rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: SizeConfig.defaultSize! * 4,
                width: 10,
                decoration:
                    const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              ),
              Container(
                height: SizeConfig.defaultSize! * 5,
                width: 3,
                color: Colors.red,
              ),
              Container(
                height: SizeConfig.defaultSize! * 4,
                width: 10,
                decoration:
                    const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
              ),
              Container(
                height: SizeConfig.defaultSize! * 5,
                width: 2,
                color: Colors.grey,
              ),
              Container(
                height: SizeConfig.defaultSize! * 4,
                width: 10,
                decoration:
                    const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Order Prepared'),
              SizedBox(height:SizeConfig.defaultSize! * 4,),
              const Text('On The Way'),
              SizedBox(height: SizeConfig.defaultSize! * 4,),

              const Text('Delivered'),
            ],
          ),
        ),
      ],
    );
  }
}
