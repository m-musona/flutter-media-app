import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../consts/colors.dart';
import '../consts/text_style.dart';
import '../controllers/audio_player_controller.dart';
import '../views/artist/artist_songs.dart';

class ListArtist extends StatelessWidget {
  final ArtistModel artist;
  final AudioPlayerController controller;
  const ListArtist({
    super.key,
    required this.artist,
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
          artist.artist,
          style: appTextStyle(size: 13),
          maxLines: 2,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          artist.numberOfTracks == 0
              ? 'No Tracks'
              : '${artist.numberOfTracks} Songs',
          style: appTextStyle(size: 12),
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
        ),
        leading: QueryArtworkWidget(
          id: artist.id,
          artworkBorder: BorderRadius.zero,
          artworkHeight: 80,
          artworkWidth: 80,
          type: ArtworkType.ARTIST,
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
          controller.getSongsFromArtist(artist).then(
                (value) => Get.to(
                  ArtistSongs(
                    audioController: controller,
                    songList: controller.artistSongs,
                  ),
                ),
              );
        },
      ),
    );
  }
}
