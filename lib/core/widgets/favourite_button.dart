import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../business_logic/home/home_cubit_cubit.dart';
import '../constants/colors.dart';
import '../constants/constants.dart';

class FavouriteButton extends StatefulWidget {
  final int productId;
  const FavouriteButton({Key? key, required this.productId}) : super(key: key);

  @override
  State<FavouriteButton> createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return BlocConsumer<HomeCubitCubit, HomeCubitState>(
      listener: (context, state) {
        if (state is AddFavouriteCubitSuccessState) {
          HomeCubitCubit.get(context).getFavourites();
        }
      },
      builder: (context, state) {
        return InkWell(
          onTap: () {
            if (prefs.getBool("is_login") == true) {
              HomeCubitCubit.get(context)
                  .addtoFavourites(productId: widget.productId);
            } else {
              Fluttertoast.showToast(
                  msg: translateString(
                      "you must login first", "يجب تسجيل الدخول اولا "),
                  backgroundColor: colorRed,
                  textColor: Colors.white,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER);
            }
          },
          child: (HomeCubitCubit.get(context).isFavourite[widget.productId] !=
                  true)
              ? Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.black87,
                  size: w * 0.08,
                )
              : Icon(
                  Icons.favorite,
                  color: colorRed,
                  size: w * 0.08,
                ),
        );
      },
    );
  }
}
