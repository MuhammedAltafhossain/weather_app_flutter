import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/ui/getx/weather_controller.dart';

import '../../data/model/location_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherController weatherController= Get.put(WeatherController());

  String? let, long, country, adminArea;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getLocation();
    weatherController.getWeather(let!, long!);
  }


  void getLocation() async {
    final service = LocationService();
    final locationData = await service.getLocation();
    if (locationData != null) {
      final placeMark = await service.getPlaceMark(locationData: locationData);

      setState(() {
        let = locationData.latitude!.toStringAsFixed(6);
        long = locationData.longitude!.toStringAsFixed(6);
        country = '${placeMark?.street}, ${placeMark?.subLocality}, ${placeMark?.locality}, ${placeMark?.country} ';

      });
     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Flutter Weather",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue.shade800,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Boise',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.2),
            ),
            Text(
              'Updated : 3:38 PM',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1),
            ),
            SizedBox(
              height: 20,
            ), 
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/weather.png',
                  width: 80,
                  fit: BoxFit.scaleDown,
                ),
                Text(
                  'Updated : 3:38 PM',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1),
                ),
                Text(
                  'Updated : 3:38 PM',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
