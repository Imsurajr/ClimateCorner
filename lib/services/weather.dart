import 'package:climatecorner/services/networking.dart';
import 'package:climatecorner/services/location.dart';

const apiKey = 'b83864a5a75ea499a62a1c69d7a3da75';
const openWeatherUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityNAme) async {
    var url = ('$openWeatherUrl?q=$cityNAme&appid=$apiKey&units=metric');
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getcurrentlocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time :))';
    } else if (temp > 20) {
      return 'Time for shorts and 👕 :)';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤 ';
    } else {
      return 'Bring a 🧥 just in case :)';
    }
  }
}
