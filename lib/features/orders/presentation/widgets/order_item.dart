import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/widgets/custom_buttons_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toot_mart/core/router/router.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/translations/locale_keys.g.dart';

class OrderItem extends StatelessWidget {
  OrderItem({Key? key, required this.index,this.isReplacment})
      : super(key: key);
  // List<Orders>? orders;
  bool? isReplacment =false;
  int? index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // MagicRouter.navigateTo(OrderItemDetails(
        //   index: index,
        //   orders: orders!.reversed.toList(),
        //   products: orders![index!].variations!,
        // ));
      },
      child: Material(
        // elevation: 2,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.transparent),
          padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    kLogo,
                    color: kMainColor,
                    height: SizeConfig.defaultSize! * 8,
                  ),
                  const   HorizontalSpace(value: 2),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order Name',
                            ),
                            Container(
                              padding:const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 5),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                '#312',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SizeConfig.defaultSize! * 1),
                              ),
                            )
                          ],
                        ),
                        const VerticalSpace(value: 0.5),
                        Text(
                          '${LocaleKeys.quantity.tr()} : 2',
                          style: TextStyle(fontSize: SizeConfig.defaultSize),
                        ),
                        const  VerticalSpace(value: 0.5),
                        Row(
                          children: [
                            Text(
                              'status',
                              style:
                                  TextStyle(fontSize: SizeConfig.defaultSize),
                            ),
                            if(isReplacment != true)
                              const Spacer(),
                            if(isReplacment != true)
                              SizedBox(

                                child: CustomTextButton(
                                  text: 'إسترجاع',
                                  size: SizeConfig.defaultSize!*1.6,
                                  color: kMainColor,
                                  isUnderLine: true,
                                  onPressed: () {
                                    // _showCustomDialog(context,orders,index!);
                                  }),
                              ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const Divider(
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(LocaleKeys.total.tr()),
                  Text('100 ${LocaleKeys.rs.tr()}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showCustomDialog(BuildContext context,int index) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration:const Duration(milliseconds: 700),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
          height: SizeConfig.defaultSize!*15,

          margin:const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(40)),
          child: SizedBox.expand(child:
       Material(
         elevation: 20,
         borderRadius: BorderRadius.circular(20),
         child: SingleChildScrollView(
           child: Column(
             children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text('هل تريد استرجاع المنتج ؟',style: TextStyle(fontSize: SizeConfig.defaultSize!*2,fontWeight:FontWeight.bold),),
               ),

               Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     SizedBox(
                       height: SizeConfig.defaultSize!*5,
                         width:  SizeConfig.defaultSize!*12,
                         child: CustomGeneralButton(text:LocaleKeys.confirm.tr(), onTap: (){
                           // OrdersCubit.get(context).refundOrder(orderId: orders![index].id!);
                           // MagicRouter.pop();
                         })),
                     SizedBox(
                       height: SizeConfig.defaultSize!*5,
                         width:  SizeConfig.defaultSize!*12,
                         child: CustomGeneralButton(text:LocaleKeys.cancel.tr(), onTap: (){
                           MagicRouter.pop();
                         })),
                    // CustomGeneralButton(text: 'text', onTap: (){}),
                   ],
                 ),
               )
             ],
           ),
         ),
       ),
         ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin:const Offset(0, 1), end: Offset.zero);
      } else {
        tween = Tween(begin:const Offset(0, -1), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}
