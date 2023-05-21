
import 'package:get/get.dart';
import 'package:weather_app/data/model/weather_model.dart';
import 'package:weather_app/data/network.dart';

import '../../data/urls.dart';

class WeatherController extends GetxController{
  WeatherModel weatherModel = WeatherModel();
  bool getWeatherInProgress = true;

  Future<bool> getWeather(String lat, String lon, ) async {
    getWeatherInProgress = true;
    update();

    final result = await Network().getMethod(Urls.baseUrl(lat, lon));
    getWeatherInProgress = false;
    update();

    if(result != null){
      weatherModel = WeatherModel.fromJson(result);
      update();
      return true;
    }
    else{
      update();
      return false;
    }


  }
}