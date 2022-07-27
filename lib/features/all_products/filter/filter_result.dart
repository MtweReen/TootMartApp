// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/features/all_products/component/product_card.dart';

import '../../../business_logic/category/category_cubit.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/constants.dart';
import '../../../core/widgets/space_widget.dart';
import '../../../data/model/filter.dart';

class FilterResultScreen extends StatefulWidget {
  final int categoryId;
  const FilterResultScreen({Key? key, required this.categoryId})
      : super(key: key);

  @override
  State<FilterResultScreen> createState() => _FilterResultScreenState();
}

class _FilterResultScreenState extends State<FilterResultScreen> {
  late ScrollController scrollController;
  int page = 1;
  bool hasNextPage = true;
  bool isFirstLoadRunning = false;
  bool isLoadMoreRunning = false;
  List products = [];

  void filterProducts() async {
    FilterResultModel? filterResultModel;
    String url = "https://site.modern-it.net/TOOT/public/api/product/filter";
    setState(() {
      isFirstLoadRunning = true;
    });
    try {
      Map<String, String> headers = {
        "Accept-Language": prefs.getString("lang") ?? "en",
      };
      Map<String, dynamic> body = {
        "min": 100,
        "max": 200,
        "sort": "asc",
        "category_id": widget.categoryId,
        "paginate": page,
      };
      Response response = await Dio().post(
        url,
        data: body,
        options: Options(headers: headers),
      );

      if (response.data['status'] == true) {
        filterResultModel = FilterResultModel.fromJson(response.data);
        setState(() {
          products = filterResultModel!.body!.products!;
        });
      }
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      isFirstLoadRunning = false;
    });
  }

  void loadMore() async {
    if (hasNextPage == true &&
        isFirstLoadRunning == false &&
        isLoadMoreRunning == false &&
        scrollController.position.extentAfter < 15) {
      String url = "https://site.modern-it.net/TOOT/public/api/product/filter";

      setState(() {
        isLoadMoreRunning = true;
        page++;
      });
      List fetchedPosts = [];
      try {
        Map<String, String> headers = {
          "Accept-Language": prefs.getString("lang") ?? "en",
        };
        Map<String, dynamic> body = {
          "min": 100,
          "max": 200,
          "sort": "asc",
          "category_id": widget.categoryId,
          "paginate": page,
        };
        Response response = await Dio().post(
          url,
          data: body,
          options: Options(headers: headers),
        );

        if (response.data['status'] == true) {
          FilterResultModel filterResultModel =
              FilterResultModel.fromJson(response.data);
          setState(() {
            fetchedPosts = filterResultModel.body!.products!;
          });
        }
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            products.addAll(fetchedPosts);
          });
        } else {
          setState(() {
            hasNextPage = false;
          });
        }
      } catch (error) {
        print("product error ----------------------" + error.toString());
      }
      setState(() {
        isLoadMoreRunning = false;
      });
    }
  }

  @override
  void initState() {
    filterProducts();
    scrollController = ScrollController()..addListener(loadMore);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return isFirstLoadRunning
        ? Center(
            child: CircularProgressIndicator(
              color: kMainColor,
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth! * 0.03,
                vertical: SizeConfig.screenHeight! * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  translateString("formations", "تشكيلات"),
                  style: headingStyle.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colordeepGrey,
                      fontSize: SizeConfig.screenWidth! * 0.05),
                ),
                const VerticalSpace(value: 2),
                (products.isNotEmpty)
                    ? Expanded(
                        child: GridView.builder(
                          controller: scrollController,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 3,
                          ),
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: products.length,
                          itemBuilder: ((ctx, index) {
                            return BlocConsumer<CategoryCubit, CategoryState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                return ProductCardData(
                                  name: products[index].title!,
                                  imge: products[index].image!,
                                  id: products[index].id,
                                  price: products[index].price,
                                );
                              },
                            );
                          }),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.screenHeight! * 0.3),
                        child: Center(
                          child: Text(
                            translateString(
                                "No products here", "لا توجد منتجات"),
                            style: TextStyle(
                                color: kMainColor,
                               
                                fontSize: SizeConfig.screenWidth! * 0.05,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                if (isLoadMoreRunning == true)
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.screenHeight! * 0.01,
                        bottom: SizeConfig.screenHeight! * 0.01),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: kMainColor,
                      ),
                    ),
                  ),

                // When nothing else to load
                if (hasNextPage == false)
                  Container(
                    padding: EdgeInsets.only(
                        top: SizeConfig.screenHeight! * 0.01,
                        bottom: SizeConfig.screenHeight! * 0.01),
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        translateString(
                            "no more products", "لا يوجد مزيد من المنتجات "),
                       
                      ),
                    ),
                  ),
              ],
            ),
          );
  }
}
