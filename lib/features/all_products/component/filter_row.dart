import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/widgets/custom_text_field.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import '../../../core/constants/constants.dart';
import '../../../core/widgets/custom_buttons_widget.dart';

TextEditingController minPrice = TextEditingController();
TextEditingController maxPrice = TextEditingController();
FocusNode minFocuse = FocusNode();
FocusNode maxFocuse = FocusNode();
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
          onTap: () {},
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
              Icon(
                Icons.keyboard_arrow_left,
                color: colordeepGrey,
                size: w * 0.07,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
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
              Icon(
                Icons.keyboard_arrow_left,
                color: colordeepGrey,
                size: w * 0.07,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

void _openModalBottomSheet(
  context,
) {
  showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              const VerticalSpace(value: 1),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                      width: 100,
                      child: Expanded(
                          child: CustomTextFormField(
                            focusNode: minFocuse,
                        controller: minPrice,
                          onEditingComplete: () {
                             minFocuse.unfocus();
                             FocusScope.of(context).requestFocus(maxFocuse);
                            },
                        hint: translateString("price from", "السعر من "),
                      ),),),

                      SizedBox(
                      width: 100,
                      child: Expanded(
                          child: CustomTextFormField(
                            focusNode: maxFocuse,
                            onEditingComplete: () {
                             maxFocuse.unfocus();
                            },
                        controller: minPrice,
                        hint: translateString("price to", "السعر الي "),
                      ),),),
                ],
              ),
              // Expanded(
              //   child: ListView.builder(
              //     padding: const EdgeInsets.all(20),
              //       shrinkWrap: false,
              //       primary: true,
              //       itemBuilder: (context, index) {
              //         return BuildProductSortingOptions(context: context,
              //             // categoryItems: categoryItems,
              //             index: index);
              //       },
              //       itemCount:3),
              // ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomGeneralButton(
                        text: "مسح الكل",
                        color: Colors.white,
                        textColor: Colors.black,
                        onTap: () {},
                      ),
                    ),
                    const HorizontalSpace(value: 3),
                    Expanded(
                      child: CustomGeneralButton(
                        text: "تأكيد",
                        textColor: Colors.white,
                        onTap: () {},
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
