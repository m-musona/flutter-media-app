import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../consts/text_style.dart';
import '../../controllers/audio_player_controller.dart';
import '../../widgets/list_playlist.dart';

class PlaylistsView extends StatelessWidget {
  final AudioPlayerController audioController;
  const PlaylistsView({
    super.key,
    required this.audioController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GetBuilder<AudioPlayerController>(
        builder: (audioController) {
          List<PlaylistModel> playlists = audioController.playlists;
          if (playlists.isEmpty) {
            return Center(
              child: Text(
                "No Playlists Found",
                style: appTextStyle(),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                PlaylistModel playlist = playlists[index];
                return ListPlaylist(
                  playlist: playlist,
                  controller: audioController,
                );
              },
            );
          }
        },
      ),
    );
  }
}
