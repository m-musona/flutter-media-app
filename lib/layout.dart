import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'consts/colors.dart';
import 'consts/text_style.dart';
import 'controllers/audio_player_controller.dart';
import 'controllers/pages_controller.dart';
import 'views/album/albums.dart';
import 'views/all_songs.dart';
import 'views/artist/artists.dart';
import 'views/genre/genres.dart';
import 'views/home.dart';
import 'views/play_queue.dart';
import 'views/playlist/playlists.dart';
import 'widgets/bottom_player.dart';
import 'widgets/sidebar.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    PagesController pagesController = Get.put(PagesController());
    AudioPlayerController audioController = Get.put(AudioPlayerController());

    final pages = [
      Home(controller: audioController),
      PlayQueueView(controller: audioController),
      PlaylistsView(audioController: audioController),
      ArtistsView(controller: audioController),
      AlbumsView(controller: audioController),
      AllSongs(audioController: audioController),
      GenresView(controller: audioController),
    ];
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: backgroundDarkColor,
      appBar: AppBar(
        backgroundColor: backgroundDarkColor,
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(
            Icons.sort_rounded,
            color: whiteColor,
          ),
        ),
        title: Text(
          "Flutter Music",
          style: appTextStyle(
            size: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: whiteColor,
            ),
          ),
        ],
      ),
      drawer: NavigationSidebar(
        pagesController: pagesController,
        scaffoldKey: scaffoldKey,
      ),
      body: Obx(() => pages[pagesController.currentPageIndex.value]),
      bottomSheet: BottomPlayer(audioController: audioController),
    );
  }
}
