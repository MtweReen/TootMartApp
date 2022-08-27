import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/core/widgets/custom_text_field.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/features/all_products/all_products.dart';
import '../../../core/constants/constants.dart';
import '../../../core/widgets/custom_buttons_widget.dart';

TextEditingController minPrice = TextEditingController();
TextEditingController maxPrice = TextEditingController();
String? selectedOrdering;
FocusNode minFocuse = FocusNode();
FocusNode maxFocuse = FocusNode();
bool filteringData = false;

class FilterProducts extends StatefulWidget {
  const FilterProducts({Key? key}) : super(key: key);

  @override
  State<FilterProducts> createState() => _FilterProductsState();
}

class _FilterProductsState extends State<FilterProducts> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      color: kMainColor,
      width: SizeConfig.screenWidth,

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                _openModalBottomSheet(context);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    translateString("filter by ", "التصنيف بحسب"),
                    style: headingStyle.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: w * 0.05),
                  ),
                  Icon(
                    (prefs.getString("lang") == "en")
                        ? Icons.keyboard_arrow_right
                        : Icons.keyboard_arrow_left,
                    color: Colors.white,
                    size: w * 0.07,
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white, width: 1,height: SizeConfig.defaultSize!*3,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                sortingProducts(context);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    translateString("Sort by ", "الترتيب بحسب"),
                    style: headingStyle.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: w * 0.05),
                  ),
                  Icon(
                    (prefs.getString("lang") == "en")
                        ? Icons.keyboard_arrow_right
                        : Icons.keyboard_arrow_left,
                    color: Colors.white,
                    size: w * 0.07,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void sortingProducts(
    context,
  ) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: SizedBox(
              height: 400,
              child: Column(
                children: [
                  const VerticalSpace(value: 2),
                  CustomGeneralButton(
                    text: translateString("low price", "سعر اقل"),
                    textColor: kMainColor,
                    color: Colors.white,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AllProducts()));
                      setState(() {
                        filteringData = true;
                        selectedOrdering = "asc";
                      });
                    },
                  ),
                  const VerticalSpace(value: 2),
                  CustomGeneralButton(
                    text: translateString("high price", "سعر اعلي"),
                    textColor: kMainColor,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AllProducts()));
                      setState(() {
                        filteringData = true;
                        selectedOrdering = "desc";
                      });
                    },
                    color: Colors.white,
                  ),
                  const VerticalSpace(value: 1),
                  // Padding(
                  //   padding: const EdgeInsets.all(20.0),
                  //   child: Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     children: [
                  //       SizedBox(
                  //         width: 150,
                  //         child: CustomGeneralButton(
                  //           text: "مسح الكل",
                  //           color: Colors.white,
                  //           textColor: Colors.black,
                  //           onTap: () {
                  //             Navigator.pop(context);
                  //              Navigator.pushReplacement(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) =>
                  //                       const AllProducts()));

                  //             setState(() {
                  //               filteringData = false;
                  //               selectedOrdering = null;
                  //             });
                  //           },
                  //         ),
                  //       ),
                  //       const HorizontalSpace(value: 3),
                  // SizedBox(
                  //   width: 150,
                  //   child: CustomGeneralButton(
                  // text: "تأكيد",
                  // textColor: Colors.white,
                  // onTap: () {
                  //   Navigator.pop(context);
                  //   Navigator.pushReplacement(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) =>
                  //               const AllProducts()));
                  //   setState(() {
                  //     filteringData = true;
                  //     selectedOrdering = null;
                  //   });
                  // },
                  // color: kMainColor,
                  //   ),
                  // ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        });
  }

  ///////////////////////////////////////////////////////////////////////////////

  void _openModalBottomSheet(
    context,
  ) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: SizedBox(
              height: 400,
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
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Expanded(
                          child: CustomTextFormField(
                            focusNode: maxFocuse,
                            onEditingComplete: () {
                              maxFocuse.unfocus();
                            },
                            controller: maxPrice,
                            hint: translateString("price to", "السعر الي "),
                          ),
                        ),
                      ),
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
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AllProducts()));
                              setState(() {
                                filteringData = false;
                                minPrice.clear();
                                maxPrice.clear();
                              });
                            },
                          ),
                        ),
                        const HorizontalSpace(value: 3),
                        Expanded(
                          child: CustomGeneralButton(
                            text: "تأكيد",
                            textColor: Colors.white,
                            onTap: () {
                              Navigator.pop(context);
                              setState(() {
                                filteringData = true;
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AllProducts()));
                              });
                            },
                            color: kMainColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
