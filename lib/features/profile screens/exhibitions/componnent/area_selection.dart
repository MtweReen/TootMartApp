// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/data/model/area.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_cubit.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../checkout/business_logic/check_out_states.dart';

class AreasSelection extends StatefulWidget {
  final bool? fromProfile;
  static int? areaId;
  const AreasSelection(
      {Key? key,
      this.text = '',
      this.fillColor = Colors.white,
      // this.onSave,
      this.borderColor, this.fromProfile,
      // this.validator
      })
      : super(key: key);

  final String text;
  final Color? fillColor;
  final Color? borderColor;
  // final Function(String?)? onSave;
  // final String? Function(String?)? validator;

  @override
  _AreasSelectionState createState() => _AreasSelectionState();
}

class _AreasSelectionState extends State<AreasSelection> {

Areas? chosenValue;
  // List<String>? categories = widget.items;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckOutCubit, CheckOutStates>(
      listener: (context, state) {
        if(state is GetAreasFilterSuccessState){
          CheckOutCubit.get(context).isfilterring = true;
        }else{
           CheckOutCubit.get(context).isfilterring = true;
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! GetAreasLoadingState,
          fallback: (context) => LinearProgressIndicator(color: kMainColor,),
          builder:(context)=> Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: (widget.borderColor == null)
                  ? Border.all(color: colorGrey)
                  : Border.all(color: widget.borderColor!),
              color: widget.fillColor!,
            ),
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: DropdownButtonFormField<Areas>(
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
              items: CheckOutCubit.get(context).areasModel!.body!.areas!.map<DropdownMenuItem<Areas>>((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(
                    value.title.toString(),
                    style:
                        headingStyle.copyWith(color: colordeepGrey, fontSize: 12),
                  ),
                );
              }).toList(),
              hint: Text(
              (widget.fromProfile == true)?translateString("All area", "جميع المناطق") :translateString("Select Shipping area", "اختر منطقة الشحن"),
                style: headingStyle.copyWith(color: colorGrey, fontSize: 14),
              ),
              onChanged: (value) {
                CheckOutCubit.get(context).getFilterArea(areaId: value!.id!);
                print(value);
                setState(() {
                  chosenValue = value;
                  AreasSelection.areaId = value.id;
                });
               chosenValue = value;
              },
              // onSaved: widget.onSave,
              // validator: widget.validator,
            ),
          ),
        );
      },
    );
  }
}
