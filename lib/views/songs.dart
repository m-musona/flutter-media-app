import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../consts/text_style.dart';
import '../controllers/audio_player_controller.dart';
import '../widgets/list_song.dart';

class SongsView extends StatelessWidget {
  final List<SongModel> songList;
  final AudioPlayerController audioController;
  final bool fromPlaylist;
  const SongsView({
    super.key,
    required this.songList,
    required this.audioController,
    required this.fromPlaylist,
  });

  @override
  Widget build(BuildContext context) {
    return songList.isEmpty
        ? Center(
            child: Text(
              "No Songs Found",
              style: appTextStyle(),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: fromPlaylist
                  ? const NeverScrollableScrollPhysics()
                  : const BouncingScrollPhysics(),
              itemCount: songList.length,
              itemBuilder: (BuildContext context, int index) {
                if (fromPlaylist) {
                  songList.sort((songA, songB) =>
                      songB.dateAdded!.compareTo(songA.dateAdded!));
                }
                SongModel song = songList[index];
                return ListSong(
                  isPlayQueue: false,
                  song: song,
                  songList: songList,
                  controller: audioController,
                  index: index,
                );
              },
            ),
          );
  }
}
