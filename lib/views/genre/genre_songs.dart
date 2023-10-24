import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../consts/colors.dart';
import '../../consts/text_style.dart';
import '../../controllers/audio_player_controller.dart';
import '../songs.dart';

class GenreSongs extends StatelessWidget {
  final AudioPlayerController audioController;
  final List<SongModel> songList;
  final GenreModel genre;
  const GenreSongs({
    super.key,
    required this.audioController,
    required this.songList,
    required this.genre,
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
                    id: genre.id,
                    artworkBorder: BorderRadius.zero,
                    artworkHeight: height,
                    artworkWidth: height,
                    artworkScale: 1.0,
                    size: height.toInt(),
                    format: ArtworkFormat.PNG,
                    type: ArtworkType.GENRE,
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
                            genre.genre,
                            style: appTextStyle(size: 15),
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            genre.numOfSongs == 0
                                ? 'No Songs'
                                : '${genre.numOfSongs} Songs',
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
              fromPlaylist: false,
            ),
          ],
        ),
      ),
    );
  }
}
