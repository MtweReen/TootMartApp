import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/business_logic/home/home_cubit_cubit.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_states.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../data/model/room.dart';
import '../../../checkout/business_logic/check_out_cubit.dart';

class AreaForExhibtionsSelection extends StatefulWidget {
  final bool? fromProfile;
  const AreaForExhibtionsSelection({
    Key? key,
    this.text = '',
    this.fillColor = Colors.white,
    this.borderColor,
    this.fromProfile,
  }) : super(key: key);

  final String text;
  final Color? fillColor;
  final Color? borderColor;

  @override
  _AreaForExhibtionsSelectionState createState() =>
      _AreaForExhibtionsSelectionState();
}

class _AreaForExhibtionsSelectionState
    extends State<AreaForExhibtionsSelection> {
  Areas? chosenValue;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubitCubit, HomeCubitState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubitCubit.get(context).roomModel != null,
          fallback: (context) => LinearProgressIndicator(
            color: kMainColor,
          ),
          builder: (context) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: (widget.borderColor == null)
                  ? Border.all(color: colorGrey)
                  : Border.all(color: widget.borderColor!),
              color: widget.fillColor!,
            ),
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: BlocConsumer<CheckOutCubit, CheckOutStates>(
              listener: (context, state) {
                if (state is GetAreasFilterSuccessState) {
                  CheckOutCubit.get(context).isfilterring = true;
                } else {
                  CheckOutCubit.get(context).isfilterring = true;
                }
              },
              builder: (context, state) {
                return DropdownButtonFormField<Areas>(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: colorGrey,
                    size: 30,
                  ),
                  iconEnabledColor: const Color.fromRGBO(148, 148, 148, 1),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  value: chosenValue,
                  items: HomeCubitCubit.get(context)
                      .roomModel!
                      .body!
                      .areas!
                      .map<DropdownMenuItem<Areas>>((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(
                        value.title.toString(),
                        style: headingStyle.copyWith(
                            color: colordeepGrey, fontSize: 12),
                      ),
                    );
                  }).toList(),
                  hint: Text(
                    (widget.fromProfile == true)
                        ? translateString("All area", "جميع المناطق")
                        : translateString(
                            "Select Shipping area", "اختر منطقة الشحن"),
                    style:
                        headingStyle.copyWith(color: colorGrey, fontSize: 14),
                  ),
                  onChanged: (value) {
                    CheckOutCubit.get(context)
                        .getFilterArea(areaId: value!.id!);
                    setState(() {
                      chosenValue = value;
                    });
                    chosenValue = value;
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
