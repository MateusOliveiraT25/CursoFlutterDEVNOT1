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

  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    checkIfFavorite();
  }

  Future<void> checkIfFavorite() async {
    List<City> cities = await _dbService.getAllCities();
    setState(() {
      isFavorite = cities.any((city) => city.cityName == widget.city && city.favoriteCities);
    });
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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_controller.weatherList.last.name),
                        IconButton(
                          icon: isFavorite ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border),
                          onPressed: () async {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                            City cidade = City(cityName: widget.city, favoriteCities: isFavorite);
                            await _dbService.updateCity(cidade);
                          },
                        ),
                      ],
                    ),
                    Text(_controller.weatherList.last.main),
                    Text(_controller.weatherList.last.description),
                    Text((_controller.weatherList.last.temp - 273).toStringAsFixed(2)),
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
