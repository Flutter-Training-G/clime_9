import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = 'a048b6028f9c1a6afbb485171e07fb28';
const apiUrl = 'http://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future getCityWeather(String? cityName) async {
    var networkHelper =
        NetworkHelper('$apiUrl?q=$cityName&units=metric&appid=$apiKey');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future getWeatherData() async {
    Location location = Location();
    await location.getCurrentLocation();

    var networkHelper = NetworkHelper(
        '$apiUrl?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=$apiKey');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
