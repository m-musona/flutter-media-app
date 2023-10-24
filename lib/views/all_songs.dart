import 'package:flutter/material.dart';

import '../controllers/audio_player_controller.dart';
import 'songs.dart';

class AllSongs extends StatelessWidget {
  final AudioPlayerController audioController;
  const AllSongs({
    super.key,
    required this.audioController,
  });

  @override
  Widget build(BuildContext context) {
    return SongsView(
      songList: audioController.allSongs,
      audioController: audioController,
      fromPlaylist: false,
    );
  }
}
