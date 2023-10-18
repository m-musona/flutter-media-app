import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioDetailsView extends StatelessWidget {
  final SongModel data;
  const AudioDetailsView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Column(
        children: [
          const Text('Audio Details'),
          Text('Album: ${data.album}'),
          Text('Artist: ${data.artist}'),
          Text('Display Name Without Extension: ${data.displayNameWOExt}'),
          Text('Uri: ${data.uri}'),
          Text('Title: ${data.title}'),
          Text('Track: ${data.track}'),
          Text('Genre: ${data.genre}'),
          Text('Is Ringtone: ${data.isRingtone}'),
          Text('Is Alarm: ${data.isAlarm}'),
          Text('Is Notification: ${data.isNotification}'),
          Text('Is Music: ${data.isMusic}'),
          Text('Is AudioBook: ${data.isAudioBook}'),
          Text('Is Podcast: ${data.isPodcast}'),
          Text('Is Blank: ${data.isBlank}'),
        ],
      ),
    );
  }
}
