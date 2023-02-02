import 'package:flutter/material.dart';
import '../services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:climatecorner/services/weather.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

// void getLocation () async {
//   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
//   print(position);
// }
class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }
  void getLocationData() async {

    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
            child: SpinKitFadingCircle(
              color: Colors.blueGrey,
              size: 50,
            ),
        ),
      );
    }
}