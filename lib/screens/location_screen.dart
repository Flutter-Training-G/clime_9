import 'dart:convert';

import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final localWeatherData;

  LocationScreen(this.localWeatherData);
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var weatherModel = WeatherModel();

  late String weatherCondition;
  late int temperature;
  late String cityName;
  late String weatherMessage;

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(widget.localWeatherData);
    updateUI(widget.localWeatherData);
  }

  void updateUI(dynamic weatherData) {
    var decodedData;
    try {
      decodedData = jsonDecode(weatherData);
    } catch (e) {
      // TODO
      print(e);
      temperature = 0;
      cityName = '';
      weatherCondition = 'Error';
      weatherMessage = 'Unable to get weather data';

      return;
    }
    // try {
    // } catch (e) {
    //   // TODO
    //   print(e);
    //   return;
    // }
    var condition = decodedData['weather'][0]['id'];
    weatherCondition = weatherModel.getWeatherIcon(condition);
    var temp = decodedData['main']['temp'];
    temperature = temp.toInt();
    cityName = decodedData['name'];
    weatherMessage = weatherModel.getMessage(temperature);
  }

  @override
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
                  TextButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      var weatherData = await weatherModel.getWeatherData();
                      print(weatherData);
                      setState(() {
                        updateUI(weatherData);
                        isLoading = false;
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var weatherData = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => CityScreen(),
                        ),
                      );
                      setState(() {
                        if (weatherData != null) {
                          updateUI(weatherData);
                        }
                      });
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
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
                    isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            weatherCondition,
                            style: kConditionTextStyle,
                          ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage ${widget.localWeatherData == null ? '' : 'in '}$cityName!",
                  textAlign: TextAlign.right,
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
