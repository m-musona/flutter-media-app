import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../consts/colors.dart';
import '../consts/text_style.dart';
import '../controllers/audio_player_controller.dart';
import '../widgets/list_song.dart';
import '../widgets/sidebar.dart';

class PlayQueueView extends StatelessWidget {
  const PlayQueueView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AudioPlayerController());
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
      drawer: const NavigationSidebar(),
      body: controller.playQueue.isEmpty
          ? Center(
              child: Text(
                "No Songs In Play Queue",
                style: appTextStyle(),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.playQueue.length,
                itemBuilder: (BuildContext context, int index) {
                  SongModel song = controller.playQueue[index];
                  return ListSong(
                    isPlayQueue: true,
                    song: song,
                    songList: controller.playQueue,
                    controller: controller,
                    index: index,
                  );
                },
              ),
            ),
    );
  }
}
