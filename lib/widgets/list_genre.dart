import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../consts/colors.dart';
import '../consts/text_style.dart';
import '../controllers/audio_player_controller.dart';
import '../views/genre/genre_songs.dart';

class ListGenre extends StatelessWidget {
  final GenreModel genre;
  final AudioPlayerController controller;
  const ListGenre({
    super.key,
    required this.genre,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        tileColor: backgroundColor,
        title: Text(
          genre.genre,
          style: appTextStyle(size: 13),
          maxLines: 2,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          genre.numOfSongs == 0 ? 'Empty Genre' : '${genre.numOfSongs} Songs',
          style: appTextStyle(size: 12),
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
        ),
        leading: QueryArtworkWidget(
          id: genre.id,
          artworkBorder: BorderRadius.zero,
          artworkHeight: 80,
          artworkWidth: 80,
          type: ArtworkType.GENRE,
          nullArtworkWidget: const Icon(
            Icons.music_note,
            color: whiteColor,
            size: 60,
          ),
        ),
        trailing: const Icon(
          Icons.more_vert,
          color: whiteColor,
          size: 26,
        ),
        onTap: () {
          controller.getSongsFromGenre(genre).then(
                (value) => Get.to(
                  GenreSongs(
                    audioController: controller,
                    songList: controller.genreSongs,
                    genre: genre,
                  ),
                ),
              );
        },
      ),
    );
  }
}
