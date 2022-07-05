
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/constants.dart';

import '../../../../core/utiles/size_config.dart';
import '../../../../core/widgets/space_widget.dart';

import '../../../core/constants/colors.dart';
import '../../../core/widgets/custom_quantity.dart';

class ShoppingItem extends StatelessWidget {
  ShoppingItem(
      {Key? key,
      // required this.cartItem,
      required this.context,
      required this.index,
      this.fromCheckOut})
      : super(key: key);

  // List<Variation> cartItem;
  int index;
  BuildContext context;
  bool? fromCheckOut;

  @override
  Widget build(BuildContext context) {
    int quantity = 10;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: colorLightGrey),
            ),
            child: Row(
              children: [
                SizedBox(
                  height: SizeConfig.defaultSize! * 10,
                  child: Image.network(
                    'https://png.pngtree.com/png-clipart/20210606/original/pngtree-3d-beauty-cosmetics-product-design-png-image_6391024.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                const HorizontalSpace(value: 1),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: Text('Anas',style: headingStyle.copyWith(fontWeight: FontWeight.bold),),),
                          IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              'asset/images/delete.png',
                              height: SizeConfig.defaultSize! * 2,
                            ),
                          )
                        ],
                      ),
                      const VerticalSpace(value: 0.5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '500 رس',
                            style: TextStyle(
                                fontSize: SizeConfig.defaultSize! * 1.5,color: kMainColor,fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              if (fromCheckOut != true)
                                CustomQuantity(child:  Image.asset(
                                  'asset/images/mince.png',
                                ),onTap: (){

                                },),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('$quantity'),
                              ),

                              CustomQuantity(child:  Image.asset(
                                'asset/images/plus.png',
                              ),onTap: (){},),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
