import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';

import '../../../business_logic/category/category_cubit.dart';
import '../../all_products/all_products.dart';

class CategoryList extends StatefulWidget {
  final List categories;
  const CategoryList({Key? key, required this.categories}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemCount: widget.categories.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            CategoryCubit.get(context)
                .getSubsCategory(id: widget.categories[index].id!);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AllProducts()));
          },
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: SizeConfig.screenHeight! * 0.25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: customCachedNetworkImage(
                      url: widget.categories[index].image.toString(),
                      fit: BoxFit.cover,
                      context: context),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth! * 0.03,
                  vertical: SizeConfig.screenHeight! * 0.03,
                ),
                child: Text(
                  widget.categories[index].title.toString(),
                  style: headingStyle.copyWith(
                      fontSize: SizeConfig.screenWidth! * 0.05,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        // ..strokeWidth = 1
                        ..color = Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const VerticalSpace(value: 2),
    );
  }
}
