import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../consts/text_style.dart';
import '../controllers/audio_player_controller.dart';
import '../widgets/list_song.dart';

class PlayQueueView extends StatelessWidget {
  final AudioPlayerController controller;
  const PlayQueueView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: controller.playQueue.isEmpty
              ? Center(
                  child: Text(
                    "No Songs In Play Queue",
                    style: appTextStyle(),
                  ),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.playQueue.length,
                  itemBuilder: (BuildContext context, int index) {
                    SongModel song = controller.playQueue[index];
                    return ListSong(
                      isPlayQueue: true,
                      song: song,
                      songList: controller.playQueue,
                      controller: controller,
                      index: index,
                    );
                  },
                ),
        ),
      ),
    );
  }
}
