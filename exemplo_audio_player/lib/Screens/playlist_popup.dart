import 'package:flutter/material.dart';

import '../Models/audio_model.dart';
class PlaylistPopup extends StatefulWidget {
final List<AudioModel> audioList;
final Function(String, List<AudioModel>) onSave;

const PlaylistPopup({
Key? key,
required this.audioList,
required this.onSave,
}) : super(key: key);

@override
_PlaylistPopupState createState() => _PlaylistPopupState();
}

class _PlaylistPopupState extends State<PlaylistPopup> {
String _playlistName = '';
List<AudioModel> _selectedAudios = [];

void _savePlaylist() {
widget.onSave(_playlistName, _selectedAudios);
Navigator.of(context).pop();
}

@override
Widget build(BuildContext context) {
return AlertDialog(
title: Text('Criar Playlist'),
content: SingleChildScrollView(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
mainAxisSize: MainAxisSize.min,
children: [
TextField(
decoration: InputDecoration(labelText: 'Nome da Playlist'),
onChanged: (value) => _playlistName = value,
),
SizedBox(height: 20),
Text('Músicas:'),
ListView.builder(
shrinkWrap: true,
itemCount: widget.audioList.length,
itemBuilder: (context, index) {
final audio = widget.audioList[index];
return CheckboxListTile(
title: Text(audio.title),
value: _selectedAudios.contains(audio),
onChanged: (checked) {
setState(() {
if (checked != null && checked) {
_selectedAudios.add(audio);
} else {
_selectedAudios.remove(audio);
}
});
},
);
},
),
],
),
),
actions: [
TextButton(
onPressed: () => Navigator.of(context).pop(),
child: Text('Cancelar'),
),
ElevatedButton(
onPressed: _selectedAudios.isNotEmpty ? _savePlaylist : null,
child: Text('Salvar'),
),
],
);
}
}

