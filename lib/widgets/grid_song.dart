import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../consts/colors.dart';
import '../consts/text_style.dart';
import '../controllers/audio_player_controller.dart';

class GridSong extends StatelessWidget {
  final SongModel song;
  final List<SongModel>? songList;
  final AudioPlayerController controller;
  final int index;
  final bool isPlayQueue;
  const GridSong({
    super.key,
    required this.song,
    required this.songList,
    required this.controller,
    required this.index,
    required this.isPlayQueue,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.playSong(
          song,
          song.uri!,
          index,
        );
        if (!isPlayQueue) {
          controller.changePlayQueue(songList);
        }
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 5),
        margin: const EdgeInsets.only(bottom: 5, left: 5),
        width: 110,
        height: 170,
        color: backgroundColor,
        child: Column(
          children: [
            QueryArtworkWidget(
              artworkBorder: BorderRadius.zero,
              artworkHeight: 110,
              artworkWidth: 110,
              id: song.id,
              type: ArtworkType.AUDIO,
              nullArtworkWidget: const Icon(
                Icons.music_note,
                color: whiteColor,
                size: 110,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song.title,
                  style: appTextStyle(),
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  song.artist!,
                  style: appTextStyle(size: 10),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
