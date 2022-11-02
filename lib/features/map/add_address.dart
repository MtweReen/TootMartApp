import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_cubit.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_states.dart';
import 'package:toot_mart/features/checkout/presentation/checkout.dart';
import 'package:toot_mart/features/map/map_provider.dart';
import 'package:toot_mart/features/profile%20screens/exhibitions/componnent/area_selection.dart';
import 'package:toot_mart/translations/locale_keys.g.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  GoogleMapController? _controller;

  void _updatePosition(CameraPosition _position, context) {
    _controller!.animateCamera(CameraUpdate.newCameraPosition(_position));
    Provider.of<MapProvider>(context, listen: false)
        .updateLat(_position.target);
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    MapProvider map = Provider.of<MapProvider>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          toolbarHeight: h * 0.11,
          leading: BackButton(
            color: kMainColor,
          ),
          elevation: 0,
           title: SizedBox(
              height: h * 0.065,
              child: TextField(
                cursorColor: Colors.black,
                readOnly: map.read,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    map.autoCompleteSearch(value);
                  } else {
                    if (map.predictions.isNotEmpty) {
                      map.clearPlaces();
                    }
                  }
                },
                onSubmitted: (val) async {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                decoration: InputDecoration(
                  focusedBorder: form(),
                  enabledBorder: form(),
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: "بحث",
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintStyle: const TextStyle(color: Colors.grey),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: h,
            width: w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.02,
                      right: MediaQuery.of(context).size.height * 0.02),
                  child: const AreasSelection(),
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                SizedBox(
                  height: h * 0.6,
                  width: w,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: h * 0.6,
                        width: w,
                        child: map.latLng == null
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: kMainColor,
                                ),
                              )
                            : GoogleMap(
                                myLocationEnabled: true,
                                onMapCreated: (controller) {
                                  _controller = controller;
                                  map.info();
                                },
                                initialCameraPosition: CameraPosition(
                                    target: map.latLng!, zoom: 18),
                                onCameraIdle: () async {
                                  await map.info();
                                },
                                markers: <Marker>{
                                  Marker(
                                    draggable: true,
                                    markerId: const MarkerId('Marker'),
                                    position: map.latLng!,
                                    icon: map.icon != null
                                        ? map.icon!
                                        : BitmapDescriptor.defaultMarker,
                                  )
                                },
                                onCameraMove: ((_position) =>
                                    _updatePosition(_position, context)),
                              ),
                      ),

                        if (map.predictions.isNotEmpty)
                        Positioned(
                          top: h * 0.02,
                          right: w * 0.1,
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 5,
                            child: Container(
                              width: w * 0.8,
                              constraints: BoxConstraints(
                                minHeight: h * 0.1,
                                maxHeight: h * 0.55,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: List.generate(
                                        map.predictions.length, (index) {
                                      return ListTile(
                                        leading: const CircleAvatar(
                                          child: Icon(
                                            Icons.pin_drop,
                                            color: Colors.white,
                                          ),
                                        ),
                                        title: Text(map
                                            .predictions[index].description!),
                                        onTap: () async {
                                          var result = await map
                                              .googlePlace.details
                                              .get(map
                                                  .predictions[index].placeId!);
                                          if (result != null &&
                                              result.result != null) {
                                            final lat = result.result!.geometry!
                                                .location!.lat;
                                            final lng = result.result!.geometry!
                                                .location!.lng;
                                            _controller!.moveCamera(
                                                CameraUpdate.newLatLng(
                                                    LatLng(lat!, lng!)));
                                            map.latLng = LatLng(lat, lng);
                                            map.clearPlaces();
                                            map.info();
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                          }
                                        },
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],

                  ),
                ),
                   Expanded(
                  child: SizedBox(
                    width: w,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: w * 0.05, left: w * 0.05, top: h * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'asset/images/noun-pin.png',
                                scale: 3,
                              ),
                              SizedBox(
                                width: w * 0.02,
                              ),
                              if (map.street == null)
                                Text(
                                  translateString("Add shipping address",
                                      "اضف عنوان الشحن "),
                                  style: TextStyle(
                                      color: kMainColor,
                                      fontSize: w * 0.045,
                                      fontWeight: FontWeight.bold),
                                ),
                              if (map.street != null)
                                Text(
                                  map.street!.length > 35
                                      ? map.street!.substring(0, 35)
                                      : map.street!,
                                  style: TextStyle(
                                      color: colordeepGrey,
                                      fontSize: w * 0.035,
                                      fontWeight: FontWeight.bold),
                                ),
                            ],
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          BlocConsumer<CheckOutCubit, CheckOutStates>(
                            listener: (context, state) {
                              if (state is AddUserAddressSuccessState) {
                                CheckOutCubit.get(context).getUserAddress();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CheckoutScreen()));
                              } else if (state is AddUserAddressErrorState) {
                                Fluttertoast.showToast(
                                  msg: translateString(
                                      "there is an error , please try again later",
                                      "حدث خطأ ما الرجاء المحاولة ف وقت لاحق"),
                                  textColor: Colors.white,
                                  backgroundColor: colorRed,
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                );
                              }
                            },
                            builder: (context, state) {
                              return InkWell(
                                child: AnimatedOpacity(
                                  duration: const Duration(seconds: 2),
                                  opacity: map.op,
                                  child: Container(
                                    height: h * 0.08,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: kMainColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        LocaleKeys.confirm.tr(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: w * 0.045,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  if (AreasSelection.areaId != null) {
                                    CheckOutCubit.get(context).addUserAddress(
                                        address: map.street.toString(),
                                        areaId: AreasSelection.areaId!,
                                        latitude: map.latLng!.latitude,
                                        longtitude: map.latLng!.longitude);
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: translateString(
                                          "you must select city",
                                          "يجب اختيار المدينة اولا "),
                                      textColor: Colors.white,
                                      backgroundColor: colorRed,
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                    );
                                  }
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  InputBorder form() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: (Colors.grey[200]!), width: 1),
      borderRadius: BorderRadius.circular(20),
    );
  }
}
