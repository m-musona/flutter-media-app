import 'package:flutter/material.dart';
import 'package:flutter_media_app/consts/colors.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../consts/text_style.dart';
import '../../controllers/audio_player_controller.dart';
import '../songs.dart';

class PlaylistSongs extends StatelessWidget {
  final AudioPlayerController audioController;
  final List<SongModel> songList;
  final PlaylistModel playlist;
  const PlaylistSongs({
    super.key,
    required this.audioController,
    required this.songList,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    double height = 150;
    return Scaffold(
      backgroundColor: backgroundDarkColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: IconButton(
          color: whiteColor,
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: backgroundColor,
              child: Row(
                children: [
                  QueryArtworkWidget(
                    id: playlist.id,
                    artworkBorder: BorderRadius.zero,
                    artworkHeight: height,
                    artworkWidth: height,
                    artworkScale: 1.0,
                    size: height.toInt(),
                    format: ArtworkFormat.PNG,
                    type: ArtworkType.PLAYLIST,
                    nullArtworkWidget: const Icon(
                      Icons.music_note,
                      color: whiteColor,
                      size: 90,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            playlist.playlist,
                            style: appTextStyle(size: 15),
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            playlist.numOfSongs == 0
                                ? 'Empty Playlist'
                                : '${playlist.numOfSongs} Songs',
                            style: appTextStyle(size: 13),
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SongsView(
              songList: songList,
              audioController: audioController,
              fromPlaylist: true,
            ),
          ],
        ),
      ),
    );
  }
}
