import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../../../business_logic/app_cubit/app_cubit.dart';
import '../../../core/utiles/size_config.dart';

class BuildProductSortingOptions extends StatefulWidget {
  const BuildProductSortingOptions(
      {Key? key,
      required this.context,
      //required this.categoryItems,
      required this.index})
      : super(key: key);

  final BuildContext context;
  // final CategoryItems categoryItems;
  final int index;

  @override
  State<BuildProductSortingOptions> createState() =>
      _BuildProductSortingOptionsState();
}

class _BuildProductSortingOptionsState
    extends State<BuildProductSortingOptions> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        backgroundColor: Colors.white,
        childrenPadding: const EdgeInsets.all(16).copyWith(top: 0),
        title: Container(
          padding:
              const EdgeInsets.all(10),
          decoration: BoxDecoration(
            // color: kMainColor,
            // borderRadius: const BorderRadius.only(
            //   topLeft: Radius.circular(15.0),
            //   topRight: Radius.circular(15.0),
            //   bottomLeft: Radius.circular(15.0),
            //   bottomRight: Radius.circular(15.0),
            // ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'name',
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
              Divider(
                thickness: 1,
                color: colorLightGrey,
              ),
            ],
          ),
        ),
        children: [
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Padding(
              padding: const EdgeInsetsDirectional.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (BuildContext context, int indexOption) {
                        return BlocBuilder<AppCubit, AppState>(
                          builder: (BuildContext context, state) =>
                              CheckboxListTile(
                            onChanged: (bool? value) {
                              // AppCubit.get(context).changeValueList(
                              //     AppCubit.get(context)
                              //         .categoryItems!
                              //         .data!
                              //         .features![widget.index]
                              //         .options![indexOption]
                              //         .id!);
                            },
                            title: Text(
                            'name',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.defaultSize! * 2)),
                            activeColor: kMainColor,
                            value:false,
                          ),
                        );
                      },
                      itemCount: 3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
