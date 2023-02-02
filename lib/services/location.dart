import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../screens/loading_screen.dart';

class Location {
    double ?latitude ;
    double ?longitude;

  Future<void> getcurrentlocation() async {
    try {
      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      latitude=position.latitude;
      longitude=position.longitude;
    }
    catch (e) {
      print(e);
    }
  }
}

