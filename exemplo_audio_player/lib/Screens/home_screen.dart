import 'package:exemplo_audio_player/services/audio_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AudioService _service = AudioService();

  Future<void> _getAudioList() async {
    try {
      await _service.fetchAudio();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _getAudioList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Player'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getAudioList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder(
          future: _getAudioList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (_service.list.isEmpty) {
              return const Center(
                child: Text('Não há músicas'),
              );
            } else {
              return ListView.builder(
                itemCount: _service.list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_service.list[index].title),
                    subtitle: Text(_service.list[index].artist),
                    trailing: IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: () {
                        // Ação a ser tomada ao pressionar o botão de play
                      },
                    ),
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
