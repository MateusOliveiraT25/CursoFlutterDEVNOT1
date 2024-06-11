import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService(
    apiKey: 'b9ebe666087f299f5e2aad3a03d093b6',
    baseUrl: 'https://api.openweathermap.org/data/2.5',
  );

  final TextEditingController _cityController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic> _weatherData = {};
  String? _errorMessage;

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _fetchWeatherData(String city) async {
    try {
      final weatherData = await _weatherService.getWeather(city);
      setState(() {
        _weatherData = weatherData;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao buscar os dados meteorológicos';
        _weatherData = {};
      });
    }
  }

   Future<void> _fetchWeatherLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final weatherData = await _weatherService.getWeatherByLocation(position.latitude, position.longitude);
      setState(() {
        _weatherData = weatherData;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao buscar os dados meteorológicos pela localização';
        _weatherData = {};
      });
    }
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
        title: Text("Exemplo Weather-API"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: "Digite o nome da cidade",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Insira o nome da cidade";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _fetchWeatherData(_cityController.text);
                  }
                },
                child: Text("Buscar por Cidade"),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _fetchWeatherLocation,
                child: Text("Buscar pela Localização Atual"),
              ),
              SizedBox(height: 20),
              if (_weatherData.isNotEmpty)
                Column(
                  children: [
                    Text('Cidade: ${_weatherData['name']}'),
                    Text('Temperatura: ${(_weatherData['main']['temp'] - 273.15).toInt()} °C'),
                    Text('Descrição: ${_translateDescription(_weatherData['weather'][0]['description'])}'),
                  ],
                ),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
