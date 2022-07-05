import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/features/all_products/component/product_sorting_options.dart';
import '../../../core/constants/constants.dart';
import '../../../core/widgets/custom_buttons_widget.dart';
import '../../../translations/locale_keys.g.dart';

class FilterProducts extends StatelessWidget {
  const FilterProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
 
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: (){},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                translateString("filter by ", "التصنيف بحسب"),
                style: headingStyle.copyWith(
                    color: colordeepGrey,
                    fontWeight: FontWeight.w700,
                    fontSize: w * 0.04),
              ),
             
              Icon(Icons.keyboard_arrow_left, color: colordeepGrey, size: w*0.07,),
            ],
          ),
        ),

          InkWell(
          onTap: (){
            _openModalBottomSheet(context);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                translateString("Sort by ", "الترتيب بحسب"),
                style: headingStyle.copyWith(
                    color: colordeepGrey,
                    fontWeight: FontWeight.w700,
                    fontSize: w * 0.04),
              ),
             
              Icon(Icons.keyboard_arrow_left, color: colordeepGrey, size: w*0.07,),
            ],
          ),
        ),
      ],
    );
  }
}
void _openModalBottomSheet(context,) {
  showModalBottomSheet(
    backgroundColor:Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          decoration:  BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight:Radius.circular(50) ),
              color: Colors.white
          ),
          child: Column(
            children: [
              VerticalSpace(value: 1),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(20),
                    shrinkWrap: false,
                    primary: true,
                    itemBuilder: (context, index) {
                      return BuildProductSortingOptions(context: context,
                          // categoryItems: categoryItems,
                          index: index);
                    },
                    itemCount:3),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomGeneralButton(
                        text: "مسح الكل",
                        color: Colors.white,
                        textColor: Colors.black,

                        onTap: () {

                        },
                      ),
                    ),
                    const HorizontalSpace(value: 3),
                    Expanded(
                      child: CustomGeneralButton(
                        text: "تأكيد",
                        textColor: Colors.white,
                        onTap: () {
                        },
                        color: kMainColor,
                      ),
                    ),
                  ],
                ),
              ),


            ],
          ),
        );
      });
}