class WeatherData {
  final String date;
  final String temperature;
  final String weather;
  final String highTemps;

  const WeatherData(this.date, this.temperature, this.weather, this.highTemps);

  factory WeatherData.getData(int index) {
    return WeatherData.dataList[index];
  }

  static List<WeatherData> dataList = [
    const WeatherData("3", "27°C", "Sunny", "29°C"),
    const WeatherData("4", "24°C", "Partially cloudy", "27°C"),
    const WeatherData("5", "21°C", "Rainy", "23°C"),
    const WeatherData("6", "18°C", "Partially cloudy", "21°C"),
    const WeatherData("7", "15°C", "Partially cloudy", "18°C"),
    const WeatherData("8", "12°C", "Partially cloudy", "15°C"),
    const WeatherData("9", "9°C", "Partially cloudy", "12°C"),
    const WeatherData("10", "6°C", "Partially cloudy", "9°C"),
    const WeatherData("11", "3°C", "Partially cloudy", "6°C"),
    const WeatherData("12", "0°C", "Partially cloudy", "3°C"),
    const WeatherData("13", "-3°C", "Partially cloudy", "0°C"),
    const WeatherData("14", "-6°C", "Partially cloudy", "-3°C"),
    const WeatherData("15", "-9°C", "Partially cloudy", "-6°C"),
    const WeatherData("16", "-12°C", "Partially cloudy", "-9°C"),

  ];
}
