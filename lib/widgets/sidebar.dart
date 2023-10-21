import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/colors.dart';
import '../consts/text_style.dart';
import '../controllers/audio_player_controller.dart';
import '../views/album/albums.dart';
import '../views/all_songs.dart';
import '../views/artist/artists.dart';
import '../views/genre/genres.dart';
import '../views/home.dart';
import '../views/play_queue.dart';
import '../views/playlist/playlists.dart';

class NavigationSidebar extends StatelessWidget {
  const NavigationSidebar({super.key});

  final double iconSize = 40;
  final double orangeIconSize = 25;

  @override
  Widget build(BuildContext context) {
    var audioController = Get.put(AudioPlayerController());
    return Drawer(
      backgroundColor: backgroundDarkColor,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  color: whiteColor,
                  size: iconSize,
                  Icons.home_rounded,
                ),
                title: Text(
                  'Home',
                  style: appTextStyle(),
                ),
                onTap: () {
                  Get.to(const Home());
                },
              ),
              const Divider(
                color: whiteColor,
              ),
              ListTile(
                leading: Icon(
                  size: orangeIconSize,
                  Icons.queue_music,
                  color: whiteColor,
                ),
                title: Text(
                  'Play Queue',
                  style: appTextStyle(size: 17),
                ),
                onTap: () {
                  Get.to(const PlayQueueView());
                },
              ),
              ListTile(
                leading: Icon(
                  size: orangeIconSize,
                  Icons.playlist_play_rounded,
                  color: whiteColor,
                ),
                title: Text(
                  'Playlists',
                  style: appTextStyle(size: 17),
                ),
                onTap: () {
                  Get.to(const PlaylistsView());
                },
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  size: orangeIconSize,
                  Icons.account_circle,
                  color: whiteColor,
                ),
                title: Text(
                  'Artists',
                  style: appTextStyle(size: 17),
                ),
                onTap: () {
                  Get.to(const ArtistsView());
                },
              ),
              ListTile(
                leading: Icon(
                  size: orangeIconSize,
                  Icons.album,
                  color: whiteColor,
                ),
                title: Text(
                  'Albums',
                  style: appTextStyle(size: 17),
                ),
                onTap: () {
                  Get.to(const AlbumsView());
                },
              ),
              ListTile(
                leading: Icon(
                  color: whiteColor,
                  size: orangeIconSize,
                  Icons.music_note_rounded,
                ),
                title: Text(
                  'Songs',
                  style: appTextStyle(size: 17),
                ),
                onTap: () {
                  Get.to(
                    AllSongs(
                      audioController: audioController,
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  color: whiteColor,
                  size: orangeIconSize,
                  Icons.piano,
                ),
                title: Text(
                  'Genres',
                  style: appTextStyle(size: 17),
                ),
                onTap: () {
                  Get.to(const GenresView());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
