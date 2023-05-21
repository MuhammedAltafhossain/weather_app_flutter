class Urls {


  static String baseUrl(String lat, String lon) =>
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=9ade3b4e4abd79ec5d833a8639a066c7';
}