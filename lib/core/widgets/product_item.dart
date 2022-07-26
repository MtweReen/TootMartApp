import 'package:flutter/material.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import '../utiles/size_config.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {Key? key,
      required this.index,
      this.press,
      required this.name,
      required this.image})
      : super(key: key);
  final int index;
  final VoidCallback? press;
  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: GridTile(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              // height: SizeConfig.defaultSize!*22,
              child: Image.network(image, fit: BoxFit.cover,)
            ),
            const VerticalSpace(value: 1),
            Text(
              name,
              style: TextStyle(fontSize: SizeConfig.defaultSize! * 1.2),
            ),
          ],
        ),
      ),
    );
  }
}
