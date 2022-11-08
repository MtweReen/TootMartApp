import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/business_logic/home/home_cubit_cubit.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/router/router.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/features/profile%20screens/exhibitions/componnent/exhibtion_map_location.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utiles/size_config.dart';

class GalleryListData extends StatefulWidget {
  const GalleryListData({Key? key}) : super(key: key);

  @override
  State<GalleryListData> createState() => _GalleryListDataState();
}

class _GalleryListDataState extends State<GalleryListData> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<HomeCubitCubit, HomeCubitState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubitCubit.get(context).roomModel != null,
          fallback: (context) {
            return Center(
              child: CircularProgressIndicator(
                color: kMainColor,
              ),
            );
          },
          builder: (context) => (HomeCubitCubit.get(context)
                  .roomModel!
                  .body!
                  .showrooms!
                  .isNotEmpty)
              ? ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: HomeCubitCubit.get(context)
                      .roomModel!
                      .body!
                      .showrooms!
                      .length,
                  separatorBuilder: (context, index) => Divider(
                    color: colorGrey,
                  ),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () => MagicRouter.navigateTo(
                      ExhibtionMapLocation(
                          latitiude: HomeCubitCubit.get(context)
                              .roomModel!
                              .body!
                              .showrooms![index]
                              .lat!,
                          longtitude: HomeCubitCubit.get(context)
                              .roomModel!
                              .body!
                              .showrooms![index]
                              .lng!,
                          city: HomeCubitCubit.get(context)
                              .roomModel!
                              .body!
                              .showrooms![index]
                              .address!,
                          name: ""),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth! * 0.02,
                          vertical: SizeConfig.screenHeight! * 0.02),
                      margin: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth! * 0.02,
                          vertical: SizeConfig.screenHeight! * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                HomeCubitCubit.get(context)
                                    .roomModel!
                                    .body!
                                    .showrooms![index]
                                    .area
                                    .toString(),
                                style: headingStyle.copyWith(
                                    color: colordeepGrey,
                                    fontWeight: FontWeight.w700,
                                    fontSize: SizeConfig.screenWidth! * 0.045),
                              ),
                              Image.asset(
                                "asset/images/location.png",
                                width: 25,
                                height: 25,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                          const VerticalSpace(value: 0.5),
                          Text(
                            HomeCubitCubit.get(context)
                                .roomModel!
                                .body!
                                .showrooms![index]
                                .address
                                .toString(),
                            style: headingStyle.copyWith(
                                color: colorGrey,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                                fontSize: SizeConfig.screenWidth! * 0.04),
                          ),
                          const VerticalSpace(value: 0.5),
                          Text(
                            translateString(
                                    "start date :  ", "يبدء من يوم : ") +
                                " " +
                                HomeCubitCubit.get(context)
                                    .roomModel!
                                    .body!
                                    .showrooms![index]
                                    .startDate
                                    .toString() +
                                " \n" +
                                translateString(
                                    "end date :  ", "تاريخ الانتهاء : ") +
                                " " +
                                HomeCubitCubit.get(context)
                                    .roomModel!
                                    .body!
                                    .showrooms![index]
                                    .endDate
                                    .toString(),
                            style: headingStyle.copyWith(
                                color: colordeepGrey,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                                fontSize: SizeConfig.screenWidth! * 0.04),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    translateString("no rooms yet", "لا توجد معارض بعد .."),
                    style: headingStyle.copyWith(
                        color: colorRed, fontWeight: FontWeight.bold),
                  ),
                ),
        );
      },
    );
  }
}
