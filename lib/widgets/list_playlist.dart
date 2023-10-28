import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../consts/colors.dart';
import '../consts/text_style.dart';
import '../controllers/audio_player_controller.dart';
import '../views/playlist/playlist_songs.dart';

class ListPlaylist extends StatelessWidget {
  final PlaylistModel playlist;
  final AudioPlayerController controller;
  const ListPlaylist({
    super.key,
    required this.playlist,
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
          playlist.playlist,
          style: appTextStyle(size: 13),
          maxLines: 2,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          playlist.numOfSongs == 0
              ? 'Empty Playlist'
              : '${playlist.numOfSongs} Songs',
          style: appTextStyle(size: 12),
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
        ),
        leading: QueryArtworkWidget(
          id: playlist.id,
          artworkBorder: BorderRadius.zero,
          artworkHeight: 80,
          artworkWidth: 80,
          type: ArtworkType.PLAYLIST,
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
          controller.getSongsFromPlaylist(playlist).then(
                (value) => Get.to(
                  PlaylistSongs(
                    audioController: controller,
                    songList: controller.playlistSongs,
                    playlist: playlist,
                  ),
                ),
              );
        },
      ),
    );
  }
}
