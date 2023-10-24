import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../consts/colors.dart';
import '../consts/text_style.dart';
import '../controllers/audio_player_controller.dart';
import '../views/album/album_songs.dart';

class GridAlbum extends StatelessWidget {
  final AlbumModel album;
  final AudioPlayerController controller;
  const GridAlbum({
    super.key,
    required this.album,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.getSongsFromAlbum(album).then(
              (value) => Get.to(
                AlbumSongs(
                  audioController: controller,
                  songList: controller.albumSongs,
                  album: album,
                ),
              ),
            );
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
              artworkHeight: 160,
              artworkWidth: 160,
              id: album.id,
              type: ArtworkType.ALBUM,
              nullArtworkWidget: const Icon(
                Icons.music_note,
                color: whiteColor,
                size: 160,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  album.album,
                  style: appTextStyle(),
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  album.artist!,
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
