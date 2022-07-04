import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/features/all_products/all_products.dart';

import '../../../core/utiles/size_config.dart';

class SubCategoryProducts extends StatefulWidget {
  const SubCategoryProducts({Key? key}) : super(key: key);

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
            children: [
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AllProducts())),
                  child: SizedBox(
                    // height: SizeConfig.screenHeight! * 0.3,
                    child: ClipRRect(
                      child: Image.network(
                        "https://img.freepik.com/free-vector/print_680502-3.jpg?size=626&ext=jpg&ga=GA1.2.756222056.1654592344",
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AllProducts())),
                  child: SizedBox(
                    // height: SizeConfig.screenHeight! * 0.3,
                    child: ClipRRect(
                      child: Image.network(
                        "https://img.freepik.com/free-vector/print_680502-3.jpg?size=626&ext=jpg&ga=GA1.2.756222056.1654592344",
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AllProducts())),
                  child: SizedBox(
                    // height: SizeConfig.screenHeight! * 0.3,
                    child: ClipRRect(
                      child: Image.network(
                        "https://img.freepik.com/free-vector/print_680502-3.jpg?size=626&ext=jpg&ga=GA1.2.756222056.1654592344",
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AllProducts())),
                  child: SizedBox(
                    // height: SizeConfig.screenHeight! * 0.3,
                    child: ClipRRect(
                      child: Image.network(
                        "https://img.freepik.com/free-vector/print_680502-3.jpg?size=626&ext=jpg&ga=GA1.2.756222056.1654592344",
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 1.5,
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AllProducts())),
                  child: SizedBox(
                    // height: SizeConfig.screenHeight! * 0.3,
                    child: ClipRRect(
                      child: Image.network(
                        "https://img.freepik.com/free-vector/print_680502-3.jpg?size=626&ext=jpg&ga=GA1.2.756222056.1654592344",
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
