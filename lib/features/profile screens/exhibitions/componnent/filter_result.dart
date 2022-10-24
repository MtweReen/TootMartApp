import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_cubit.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_states.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/router/router.dart';
import '../../../../core/utiles/size_config.dart';
import '../../../../core/widgets/space_widget.dart';
import 'exhibtion_map_location.dart';

class AreaFilterringResult extends StatefulWidget {
  const AreaFilterringResult({Key? key}) : super(key: key);

  @override
  State<AreaFilterringResult> createState() => _AreaFilterringResultState();
}

class _AreaFilterringResultState extends State<AreaFilterringResult> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<CheckOutCubit, CheckOutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! GetAreasFilterLoadingState,
          fallback: (context) {
            return Center(
              child: CircularProgressIndicator(
                color: kMainColor,
              ),
            );
          },
          builder: (context) => (CheckOutCubit.get(context)
                  .areaFilterResult!
                  .body!
                  .showrooms!
                  .isNotEmpty)
              ? ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: CheckOutCubit.get(context)
                      .areaFilterResult!
                      .body!
                      .showrooms!
                      .length,
                  separatorBuilder: (context, index) => Divider(
                    color: colorGrey,
                  ),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () => MagicRouter.navigateTo(
                      ExhibtionMapLocation(
                          latitiude: CheckOutCubit.get(context)
                              .areaFilterResult!
                              .body!
                              .showrooms![index]
                              .lat!,
                          longtitude: CheckOutCubit.get(context)
                              .areaFilterResult!
                              .body!
                              .showrooms![index]
                              .lng!,
                          city: CheckOutCubit.get(context)
                              .areaFilterResult!
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
                                CheckOutCubit.get(context)
                                    .areaFilterResult!
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
                            CheckOutCubit.get(context)
                                .areaFilterResult!
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
                                CheckOutCubit.get(context)
                                    .areaFilterResult!
                                    .body!
                                    .showrooms![index]
                                    .startDate
                                    .toString() +
                                " \n" +
                                translateString(
                                    "end date :  ", "تاريخ الانتهاء : ") +
                                " " +
                                CheckOutCubit.get(context)
                                    .areaFilterResult!
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
