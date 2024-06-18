import 'package:flutter/material.dart';
import 'package:projeto_api_geo/Controller/weather_controller.dart';
import 'package:projeto_api_geo/Service/city_db_service.dart';

import '../Model/city_model.dart';

class DetailsWeatherScreen extends StatefulWidget {
  final String city;
  const DetailsWeatherScreen({Key? key, required this.city}) : super(key: key);

  @override
  State<DetailsWeatherScreen> createState() => _DetailsWeatherScreenState();
}

class _DetailsWeatherScreenState extends State<DetailsWeatherScreen> {
  final WeatherController _controller = WeatherController();
  final CityDataBaseService _dbService = CityDataBaseService();

  bool isHistory = false;

  @override
  void initState() {
    super.initState();
    checkIfHistory();
  }

  Future<void> checkIfHistory() async {
    List<City> cities = await _dbService.getAllCities();
    setState(() {
      isHistory = cities.any((city) => city.cityName == widget.city && city.historyCities);
    });
  }

  String _translateDescription(String description) {
    switch (description.toLowerCase()) {
      case 'clear sky':
        return 'céu limpo';
      case 'few clouds':
        return 'poucas nuvens';
      case 'scattered clouds':
        return 'nuvens esparsas';
      case 'broken clouds':
        return 'céu nublado';
      case 'shower rain':
        return 'chuvisco';
      case 'rain':
        return 'chuva';
      case 'thunderstorm':
        return 'trovoada';
      case 'snow':
        return 'neve';
      case 'mist':
        return 'névoa';
      default:
        return description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: FutureBuilder(
            future: _controller.getWeather(widget.city),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              } else {
                final weather = _controller.weatherList.last;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(weather.name),
                        IconButton(
                          icon: isHistory ? const Icon(Icons.history) : const Icon(Icons.favorite_border),
                          onPressed: () async {
                            setState(() {
                              isHistory = !isHistory;
                            });
                            City cidade = City(cityName: widget.city, historyCities: isHistory);
                            await _dbService.updateCity(cidade);
                          },
                        ),
                      ],
                    ),
                    Text(weather.main),
                    Text(_translateDescription(weather.description)),
                    Text((weather.temp - 273).toStringAsFixed(2)),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}