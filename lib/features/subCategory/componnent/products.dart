import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:toot_mart/features/all_products/all_products.dart';
import 'package:toot_mart/features/detail/product_detail.dart';
import '../../../core/utiles/size_config.dart';

class SubCategoryProducts extends StatefulWidget {
 final List products;
  const SubCategoryProducts({Key? key, required this.products,}) : super(key: key);

  @override
  State<SubCategoryProducts> createState() => _SubCategoryProductsState();
}

class _SubCategoryProductsState extends State<SubCategoryProducts> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      height: SizeConfig.screenHeight! * 0.3,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            children:List.generate(widget.products.length, (index) =>   StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProductDetailScreen())),
                  child: SizedBox(
                    // height: SizeConfig.screenHeight! * 0.3,
                    child: ClipRRect(
                      child: Image.network(
                        widget.products[index].image.toString(),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),),
            
          ),),
    );
  }
}
