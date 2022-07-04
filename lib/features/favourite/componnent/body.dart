import 'package:flutter/material.dart';

import '../../../core/utiles/size_config.dart';
import '../../all_products/component/product_grid.dart';

class FavouriteBody extends StatefulWidget {
  const FavouriteBody({ Key? key }) : super(key: key);

  @override
  State<FavouriteBody> createState() => _FavouriteBodyState();
}

class _FavouriteBodyState extends State<FavouriteBody> {
  @override
  Widget build(BuildContext context) {
     SizeConfig().init(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth! * 0.03,
          vertical: SizeConfig.screenHeight! * 0.03),
      child:  ProductGridData(fromfav: true,),
        
    );
  
  }
}