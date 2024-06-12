class AudioModel {
  final String title;
  final String artist;
  final String url;
  final String imageUrl;

  AudioModel({
    required this.title,
    required this.artist,
    required this.url,
    required this.imageUrl,
  });

  factory AudioModel.fromMap(Map<String, dynamic> map) {
    return AudioModel(
      title: map['title'],
      artist: map['artist'],
      url: map['url'],
      imageUrl: map['imageUrl'],
    );
  }
}

