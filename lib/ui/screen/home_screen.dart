import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/ui/getx/weather_controller.dart';

import '../../data/model/location_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherController weatherController = Get.put(WeatherController());

  String? let;
  String? long;
  String? country, adminArea;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  double kelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }

  void getLocation() async {
    final service = LocationService();
    final locationData = await service.getLocation();
    if (locationData != null) {
      final placeMark = await service.getPlaceMark(locationData: locationData);

      setState(() {
        let = locationData.latitude!.toStringAsFixed(2);
        long = locationData.longitude!.toStringAsFixed(2);
        weatherController.getWeather(let ?? '', long ?? '').then((value) => {
        if(value == false){
          Get.snackbar(
          "error",
          "Data Fatch Error. Please Try Again...!",
          colorText: Colors.white,
          backgroundColor: Colors.deepPurple.shade100,
          icon: const Icon(Icons.error),
        )
      }});
        country =
        '${placeMark?.street}, ${placeMark?.subLocality}, ${placeMark?.locality}, ${placeMark?.country} ';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Flutter Weather",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        actions: const [
          Icon(
            Icons.settings,
            color: Colors.white,
          ),
          SizedBox(
            width: 12,
          ),
          Icon(
            Icons.add,
            color: Colors.white,
          ),
          SizedBox(
            width: 12,
          ),
        ],
      ),
      body: GetBuilder<WeatherController>(builder: (controller) {
        if (controller.getWeatherInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final weather = controller.weatherModel.weather?.first;
        final main = controller.weatherModel.main;
        final max = kelvinToCelsius(main?.tempMax ?? 0.0);
        final min = kelvinToCelsius(main?.tempMin ?? 0.0);
        final temp = kelvinToCelsius(main?.temp ?? 0.0);
        return RefreshIndicator(
          onRefresh: () async {
            getLocation();
          },
          child: Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.weatherModel.name ?? '',
                  style: const TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2.2,
                      fontFamily: 'Kanit'),
                ),
                Text(
                  'Updated : ${DateFormat('hh:mm:ss a').format(
                      DateTime.now())}',
                  style: const TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      fontFamily: 'Kanit'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/weather.png',
                        width: 80,
                        fit: BoxFit.scaleDown,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        '${temp.toStringAsFixed(0)}\u00B0',
                        style: const TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                            fontFamily: 'Kanit'),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Column(
                        children: [
                          Text(
                            'max: ${max.toStringAsFixed(0)}\u00B0',
                            style: const TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                                fontFamily: 'Kanit'),
                          ),
                          Text(
                            'min: ${min.toStringAsFixed(0)}\u00B0 ',
                            style: const TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                                fontFamily: 'Kanit'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  weather?.main ?? '',
                  style: const TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      fontFamily: 'Kanit'),
                ),
              ],
            ),
          ]),
        );
      }),
    );
  }
}
