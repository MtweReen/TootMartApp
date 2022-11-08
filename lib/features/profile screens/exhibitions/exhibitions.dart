import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/business_logic/home/home_cubit_cubit.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_cubit.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_states.dart';
import 'package:toot_mart/features/profile%20screens/exhibitions/componnent/area_selection.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utiles/size_config.dart';
import 'componnent/body.dart';
import 'componnent/filter_result.dart';

class ExhibitionsScreen extends StatelessWidget {
  const ExhibitionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: customAppbar(
        title: translateString("Exhibition sites", "مواقع المعارض"),
        context: context,
        press: () => Navigator.pop(context),
      ),
      body: RefreshIndicator(
        onRefresh: () async => await HomeCubitCubit.get(context).getRooms(),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth! * 0.03,
              vertical: SizeConfig.screenHeight! * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                translateString("Show gallery from", "اظهار المعرض من"),
                style: headingStyle.copyWith(
                    color: colordeepGrey,
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.screenWidth! * 0.045),
              ),
              const VerticalSpace(value: 1.5),
              const AreasSelection(
                fromProfile: true,
              ),
              const VerticalSpace(value: 1.5),
              BlocConsumer<CheckOutCubit, CheckOutStates>(
                builder: (context, state) =>
                    (CheckOutCubit.get(context).isfilterring == true)
                        ? const AreaFilterringResult()
                        : const GalleryListData(),
                listener: (context, state) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
