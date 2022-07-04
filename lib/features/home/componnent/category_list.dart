import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

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
      itemCount: 6,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {},
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
                  child: Image.network(
                    "https://img.freepik.com/free-vector/minimal-geometric-design-flyer-poster-brochure-cover-background-wallpaper-typography-other-printing-products-vector-illustration_6343-1020.jpg?w=1380",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth! * 0.03,
                  vertical: SizeConfig.screenHeight! * 0.03,
                ),
                child: Text(
                  "ابهريهم بفازتك ",
                  style: headingStyle.copyWith(
                      fontSize: SizeConfig.screenWidth!*0.05,
                    
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
