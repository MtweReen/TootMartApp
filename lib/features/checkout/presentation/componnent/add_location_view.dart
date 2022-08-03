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
import '../../../map/add_address.dart';

class AddLocationView extends StatefulWidget {
  const AddLocationView({Key? key}) : super(key: key);

  @override
  State<AddLocationView> createState() => _AddLocationViewState();
}

class _AddLocationViewState extends State<AddLocationView> {
  @override
  void initState() {
    CheckOutCubit.get(context).getUserAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  'asset/images/location.png',
                  color: Colors.black,
                  height: SizeConfig.defaultSize! * 4,
                ),
                const HorizontalSpace(value: 1),
                Text(
                  'تحديد العنوان',
                  style: headingStyle,
                ),
                const Spacer(),
                IconButton(
                    icon: Image.asset(
                      'asset/images/plus.png',
                      height: SizeConfig.defaultSize! * 2.5,
                    ),
                    onPressed: () {
                      MagicRouter.navigateTo(const AddAddress());
                    }),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: colorLightGrey,
          ),
          SizedBox(
            height: SizeConfig.screenHeight! * 0.02,
          ),
          BlocConsumer<CheckOutCubit, CheckOutStates>(
            builder: (context, state) => ConditionalBuilder(
              condition: state is! GetUserAddressLoadingState ||
                  CheckOutCubit.get(context).userAddressModel != null,
              fallback: (context) => Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: CircularProgressIndicator(
                    color: kMainColor,
                  )),
              builder: (context) => ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (context, index) => Text(
                        CheckOutCubit.get(context)
                            .userAddressModel!
                            .body!
                            .userAddress![index]
                            .address!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style:
                            headingStyle.copyWith(fontWeight: FontWeight.w400),
                      ),
                  separatorBuilder: (context, index) => Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.screenHeight! * 0.02,
                          ),
                          Divider(
                            color: kMainColor,
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight! * 0.02,
                          ),
                        ],
                      ),
                  itemCount: CheckOutCubit.get(context)
                      .userAddressModel!
                      .body!
                      .userAddress!
                      .length),
            ),
            listener: (context, state) {},
          ),
        ],
      ),
    );
  }
}
