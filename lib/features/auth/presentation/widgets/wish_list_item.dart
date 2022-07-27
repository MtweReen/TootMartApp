import 'package:toot_mart/core/constants/colors.dart';
import 'package:flutter/material.dart';

import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';



import '../../data/model/favourites_model.dart';

class WishListItem extends StatelessWidget {
  const WishListItem({Key? key,required this.favouritesModel, required this.index}) : super(key: key);
  final FavouritesModel favouritesModel;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0) ,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey.shade300
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton( onPressed: () {
              // AppCubit.get(context).toggelFavourite(productId: favouritesModel.data![index].id);
              // AuthCubit.get(context).getFavouteProducts();
            }, icon: Icon(Icons.close,color: kMainColor,)),
            Expanded(child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.network(favouritesModel.data![index].imagePath!,height: SizeConfig.defaultSize!*12,fit: BoxFit.cover,))),
            const HorizontalSpace(value: 2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: SizeConfig.defaultSize!*15,
                    child: Text(favouritesModel.data![index].name!,maxLines: 2,)),
                const VerticalSpace(value: 2),
                Text('${favouritesModel.data![index].price!} {LocaleKeys.rs.tr()}'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
