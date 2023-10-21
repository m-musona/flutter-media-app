import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../consts/colors.dart';
import '../consts/text_style.dart';
import '../controllers/audio_player_controller.dart';
import '../views/audio_player.dart';

class ListSong extends StatelessWidget {
  final SongModel song;
  final List<SongModel> songList;
  final AudioPlayerController controller;
  final int index;
  final bool isPlayQueue;
  const ListSong({
    super.key,
    required this.song,
    required this.controller,
    required this.index,
    required this.songList,
    required this.isPlayQueue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Obx(
        () => ListTile(
          contentPadding: const EdgeInsets.all(0),
          tileColor: backgroundColor,
          title: Text(
            song.title,
            style: appTextStyle(size: 13),
            maxLines: 2,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            song.artist!,
            style: appTextStyle(size: 12),
            maxLines: 1,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
          leading: isPlayQueue
              ? const Icon(
                  Icons.unfold_more_rounded,
                  color: whiteColor,
                  size: 26,
                )
              : QueryArtworkWidget(
                  id: song.id,
                  artworkBorder: BorderRadius.zero,
                  artworkHeight: 80,
                  artworkWidth: 80,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: const Icon(
                    Icons.music_note,
                    color: whiteColor,
                    size: 60,
                  ),
                ),
          trailing: controller.currentlyPlayingSongID.value == song.id &&
                  controller.isPlaying.value
              ? const Icon(
                  Icons.play_arrow,
                  color: whiteColor,
                  size: 26,
                )
              : const Icon(
                  Icons.more_vert,
                  color: whiteColor,
                  size: 26,
                ),
          onTap: () {
            controller.playSongAndAddToPlayQueue(
              song.id,
              song.uri!,
              songList,
              index,
            );
            Get.to(
              () => AudioPlayerScreen(
                data: songList,
              ),
              transition: Transition.downToUp,
            );
          },
        ),
      ),
    );
  }
}
