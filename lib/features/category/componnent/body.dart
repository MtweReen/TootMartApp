// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:toot_mart/business_logic/category/category_cubit.dart';
import 'package:toot_mart/core/network/end_points.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/constants.dart';
import '../../../core/widgets/product_item.dart';
import '../../../data/model/category.dart';
import '../../all_products/component/filter_row.dart';
import '../../subCategory/sub_categrory.dart';

class CategoryBody extends StatefulWidget {
  const CategoryBody({Key? key}) : super(key: key);

  @override
  State<CategoryBody> createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  late ScrollController scrollController;
  int page = 1;
  bool hasNextPage = true;
  bool isFirstLoadRunning = false;
  bool isLoadMoreRunning = false;
  List categories = [];

  String lang = '';
  String currency = '';

  void firstLoad() async {
    CategoryModel? categoryModel;

    setState(() {
      isFirstLoadRunning = true;
    });
    try {
      Map<String, String> headers = {
        "Accept-Language": prefs.getString("lang") ?? "ar",
      };
      var response = await http.get(
        Uri.parse(kBaseUrl + CATEGORIES + "?page=$page"),
        headers: headers,
      );
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        categoryModel = CategoryModel.fromJson(data);
        setState(() {
          categories = categoryModel!.body!.categories!;
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
      Map<String, String> headers = {
        "Accept-Language": prefs.getString("lang") ?? "en",
      };
      setState(() {
        isLoadMoreRunning = true;
        page++;
      });
      List fetchedPosts = [];
      try {
        var response = await http.get(
            Uri.parse(kBaseUrl + CATEGORIES + "?page=$page"),
            headers: headers);
        var data = jsonDecode(response.body);
        if (data['status'] == true) {
          CategoryModel categoryModel = CategoryModel.fromJson(data);
          setState(() {
            fetchedPosts = categoryModel.body!.categories!;
          });
        }
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            categories.addAll(fetchedPosts);
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
    firstLoad();
    scrollController = ScrollController()..addListener(loadMore);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return RefreshIndicator(
        child: isFirstLoadRunning
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
                  
                    (categories.isNotEmpty)
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
                              itemCount: categories.length,
                              itemBuilder: ((ctx, index) {
                                return BlocConsumer<CategoryCubit,
                                    CategoryState>(
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    return ProductItem(
                                      name: categories[index].title!,
                                      image: categories[index].image!,
                                      index: index,
                                      press: () {
                                        setState(() {
                                          filteringData = false;
                                        });
                                        CategoryCubit.get(context)
                                            .getSubsCategory(
                                                id: categories[index].id!);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SubCategoryScreen(
                                              id: categories[index].id!,
                                              name: categories[index].title!,
                                              image: categories[index].image!,
                                            ),
                                          ),
                                        );
                                      },
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
                            translateString("no more products",
                                "لا يوجد مزيد من المنتجات "),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
        onRefresh: () async => firstLoad());
  }
}
