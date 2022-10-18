// ignore_for_file: avoid_print, empty_catches

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:location/location.dart' as lo;
import 'package:toot_mart/core/constants/constants.dart';

const kGoogleApiKey = "AIzaSyBxCWZSLFx6zvcjHUGC268Mrkw0EREsyb8";

class MapProvider extends ChangeNotifier {
  List<AutocompletePrediction> predictions = [];
  GooglePlace googlePlace = GooglePlace(
    kGoogleApiKey,
  );
  lo.Location location = lo.Location();
  bool read = true;
  double op = 0.3;
  LatLng? latLng;
  String? country, street;
  BitmapDescriptor? icon;

  Future start() async {
    try {
      BitmapDescriptor.fromAssetImage(
              ImageConfiguration.empty, 'asset/images/noun-pin.png')
          .then((value) {
        icon = value;
        notifyListeners();
      });
      if (latLng == null) {
        bool _serviceEnabled;
        lo.PermissionStatus _permissionGranted;
        lo.LocationData _locationData;
        _serviceEnabled = await location.serviceEnabled();
        if (!_serviceEnabled) {
          _serviceEnabled = await location.requestService();
          if (!_serviceEnabled) {}
        }
        _permissionGranted = await location.hasPermission();
        if (_permissionGranted == lo.PermissionStatus.denied) {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted != lo.PermissionStatus.granted) {
            _locationData = await location.getLocation();
            if (_locationData.longitude != null) {
              latLng =
                  LatLng(_locationData.latitude!, _locationData.longitude!);
              read = false;
              op = 1;
            }
          }
        }
        if (latLng == null) {
          if (_permissionGranted == lo.PermissionStatus.granted ||
              _permissionGranted == lo.PermissionStatus.grantedLimited) {
            _locationData = await location.getLocation();
            if (_locationData.longitude != null) {
              latLng =
                  LatLng(_locationData.latitude!, _locationData.longitude!);

              read = false;
              op = 1;
            }
          }
        }
      }
      if (latLng == null) {}
    } catch (e) {
      latLng = const LatLng(29.3057, 48.0308);
      read = false;
      op = 1;
    }
    if (latLng == null) {
      latLng = const LatLng(29.3057, 48.0308);
      read = false;
      op = 1;
    }

    info();
  }

  Future info() async {
    if (Platform.isIOS || Platform.isAndroid) {
      try {
        late String local;
        if (prefs.getString("lang") == 'en') {
          local = 'enUS';
        } else {
          local = 'idID';
        }
        List<Placemark> placemarks = await placemarkFromCoordinates(
            latLng!.latitude, latLng!.longitude,
            localeIdentifier: local);
        Placemark placeMark = placemarks[0];
        String? name = placeMark.name;
        String? subLocality = placeMark.subLocality;
        String? locality = placeMark.locality;
        String administrativeArea = placeMark.administrativeArea ?? '';
        String? postalCode = placeMark.postalCode;
        String country = placeMark.country ?? '';
        String? street = placeMark.street;
        String? subArea = placeMark.subAdministrativeArea;
        String? thoroughfare = placeMark.thoroughfare;
        String? address =
            "1-$name\n2-$subLocality\n3-$locality\n4-$administrativeArea\n5-$postalCode\n6-$country\n7-$street\n8-$subArea\n9-$thoroughfare";
        print(address);
        // if (name != '') {
        //   this.street = name;
        // } else if (thoroughfare != '') {
        //   this.street = thoroughfare;
        // } else
        if (street != '') {
          this.street = street;
        } else {
          this.street = name;
        }
        this.country = country + ', ' + administrativeArea;
        notifyListeners();
      } catch (e) {}
    }
    notifyListeners();
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value,
        language: "ar",
        radius: 100000,
        location: LatLon(latLng!.latitude, latLng!.longitude));
    print(result!.status);
    if (result != null || result.predictions != null) {
      predictions.addAll(result.predictions!);
      // print(predictions);
      notifyListeners();
    }
  }

  void updateLat(LatLng _latLng) {
    latLng = _latLng;
    notifyListeners();
  }

  void clearPlaces() {
    predictions = [];
    notifyListeners();
  }
}
