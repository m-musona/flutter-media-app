import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../consts/colors.dart';
import '../../consts/text_style.dart';
import '../../controllers/audio_player_controller.dart';
import '../songs.dart';

class ArtistSongs extends StatelessWidget {
  final AudioPlayerController audioController;
  final List<SongModel> songList;
  final ArtistModel artist;
  const ArtistSongs({
    super.key,
    required this.audioController,
    required this.songList,
    required this.artist,
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
                    id: artist.id,
                    artworkBorder: BorderRadius.zero,
                    artworkHeight: height,
                    artworkWidth: height,
                    artworkScale: 1.0,
                    size: height.toInt(),
                    format: ArtworkFormat.PNG,
                    type: ArtworkType.ARTIST,
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
                            artist.artist,
                            style: appTextStyle(size: 15),
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            artist.numberOfTracks == 0
                                ? 'No Albums'
                                : '${artist.numberOfAlbums} Albums',
                            style: appTextStyle(size: 13),
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            artist.numberOfTracks == 0
                                ? 'No Songs'
                                : '${artist.numberOfTracks} Songs',
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
