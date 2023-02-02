import 'package:flutter/material.dart';
import 'city_screen.dart';
import '../utilities/constants.dart';
import 'package:climatecorner/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late int temperature;
  late String weatherIcon;
  late String weatherMessage;
  String? cityname;
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'error';
        weatherMessage = 'Unable to get weather data';
        cityname = '';
        return;
        //return = break;

      }

      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      weatherMessage = weather.getMessage(temperature);
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      cityname = weatherData['name'];
      print(cityname);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey),
                    ),
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(

                      Icons.near_me,
                      size: 35.0,
                    ),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey),
                    ),
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName!=null) {
                        var weatherData = await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.search,
                      size: 35.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $cityname",
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
