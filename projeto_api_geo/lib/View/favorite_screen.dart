import 'package:flutter/material.dart';
import 'package:projeto_api_geo/Service/city_db_service.dart';
import 'details_weather_screen.dart';
import '../Model/city_model.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final CityDataBaseService _dbService = CityDataBaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Historico")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: FutureBuilder<List<City>>(
          future: _dbService.getAllCities(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Erro ao carregar cidades favoritas"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("Sem cidades favoritas"));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final city = snapshot.data![index];
                  return ListTile(
                    title: Text(city.cityName),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => DetailsWeatherScreen(city: city.cityName),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
