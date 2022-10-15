import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/constants/constants.dart';

class ExhibtionMapLocation extends StatefulWidget {
  final String latitiude;
  final String longtitude;
  final String city;
  final String name;
  const ExhibtionMapLocation(
      {Key? key,
      required this.latitiude,
      required this.longtitude,
      required this.city,
      required this.name})
      : super(key: key);

  @override
  State<ExhibtionMapLocation> createState() => _ExhibtionMapLocationState();
}

class _ExhibtionMapLocationState extends State<ExhibtionMapLocation> {
  GoogleMapController? mapController; //contrller for Google map
  List<Polyline> myPolyline = [];
  Set<Marker> markers = {};
  // LatLng startLocation =
  //     LatLng(SplashScreen.startLatitude!, SplashScreen.startLongitude!);

  String? lang;
  getLanguage() async {
    final String language = prefs.getString('lang') ?? 'ar';
    setState(() {
      lang = language;
    });
  }

  @override
  void initState() {
    super.initState();
    // createPolyline();
    getLanguage();
    markers.add(
      Marker(
          markerId: MarkerId(LatLng(double.parse(widget.latitiude),
                  double.parse(widget.longtitude))
              .toString()),
          position: LatLng(double.parse(widget.latitiude),
              double.parse(widget.longtitude)), //position of marker
          infoWindow: InfoWindow(
            title: widget.name,
            snippet: widget.city,
          ),
          icon: BitmapDescriptor.defaultMarker //Icon for Marker
          ),
    );
  }

  // createPolyline() {
  //   myPolyline.add(
  //     Polyline(
  //         polylineId: const PolylineId('1'),
  //         color: const Color(0xff3366cc),
  //         width: 5,
  //         points: [
  //           LatLng(startLocation.latitiude, startLocation.longitude),
  //           LatLng(
  //             double.parse(widget.latitiude),
  //             double.parse(widget.longtitude),
  //           ),
  //         ]),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 0.0,
      ),
      body: Stack(
        children: [
          googleMapUI(),
          backIcon(w: w, h: h),
        ],
      ),
    );
  }

  backIcon({required double w, required double h}) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: h * 0.01, horizontal: w * 0.03),
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: w * 0.1,
            height: h * 0.1,
            padding: (lang == 'en')
                ? EdgeInsets.only(
                    left: w * 0.02,
                  )
                : EdgeInsets.only(
                    right: w * 0.02,
                  ),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: const Offset(0, 3),
                      spreadRadius: 3,
                      blurRadius: 3)
                ]),
            child: Center(
              child: (lang == 'en')
                  ? Icon(
                      Icons.arrow_back_ios,
                      color: const Color.fromARGB(255, 3, 24, 66),
                      size: w * 0.07,
                    )
                  : Icon(
                      Icons.arrow_forward_ios,
                      color: const Color.fromARGB(255, 3, 24, 66),
                      size: w * 0.07,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget googleMapUI() {
    return Column(
      children: [
        Expanded(
          child: GoogleMap(
            mapType: MapType.normal,
            markers: markers,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                double.parse(widget.latitiude),
                double.parse(widget.longtitude),
              ),
              zoom: 10,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) async {},
            // polylines: myPolyline.toSet(),
          ),
        ),
      ],
    );
  }
}
