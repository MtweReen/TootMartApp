
// geolocator: ^8.2.0
// geocoding: ^2.0.1

// final Geolocator geolocator = Geolocator();
// late Position currentPosition;

// getCurrentLocation() async {
//   LocationPermission permission;
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error('Location Not Available');
//     }
//   } else {}
//
//   Geolocator.getCurrentPosition(
//     desiredAccuracy: LocationAccuracy.best,
//   ).then((Position position) async {
//     setState(() {
//       currentPosition = position;
//     });
//     getAddressFromLatLong(currentPosition);
//     SharedPreferences pres = await SharedPreferences.getInstance();
//     pres.setString('late', position.altitude.toString());
//     pres.setString('lang', position.longitude.toString());
//   }).catchError((e) {
//     print("location errrrrrrrrrrrrrrrrrrrrrrrr : " + e.toString());
//   });
// }
//
// Future<void> getAddressFromLatLong(Position position) async {
//   List<Placemark> placemarks =
//   await placemarkFromCoordinates(position.latitude, position.longitude);
//   Placemark place = placemarks[0];
//   String address = '${place.street}, ${place.locality},${place.country}';
//   CasheHelper.saveData(key: 'country', value: place.country);
//   CasheHelper.saveData(key: 'city', value: place.locality);
//   CasheHelper.saveData(key: 'address', value: address);
//   print("user address: " + address);
// }