import 'package:exemplo_audio_player/models/audio_model.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerScreen extends StatefulWidget {
  final List<AudioModel> audioList;
  final int initialIndex;
  const AudioPlayerScreen({super.key, required this.audioList, this.initialIndex = 0});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _currentIndex = widget.initialIndex;
    _playCurrentAudio();
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playCurrentAudio() {
    _audioPlayer.setSource(UrlSource(widget.audioList[_currentIndex].url));
    _audioPlayer.play(UrlSource(widget.audioList[_currentIndex].url));
  }

  void _playPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play(UrlSource(widget.audioList[_currentIndex].url));
    }
  }

  void _playNext() {
    if (_currentIndex < widget.audioList.length - 1) {
      _currentIndex++;
      _playCurrentAudio();
    }
  }

  void _playPrevious() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _playCurrentAudio();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.audioList[_currentIndex].title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.skip_previous),
              iconSize: 64.0,
              onPressed: _playPrevious,
            ),
            IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              iconSize: 64.0,
              onPressed: _playPause,
            ),
            IconButton(
              icon: Icon(Icons.skip_next),
              iconSize: 64.0,
              onPressed: _playNext,
            ),
            Text(
              _isPlaying ? 'Reproduzindo' : 'Pausado',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
