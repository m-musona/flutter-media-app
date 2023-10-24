import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../consts/text_style.dart';
import '../controllers/audio_player_controller.dart';
import '../widgets/grid_song.dart';

class Home extends StatelessWidget {
  final AudioPlayerController controller;
  const Home({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Play Queue',
              textAlign: TextAlign.left,
              style: appTextStyle(size: 16),
            ),
          ),
          Obx(
            () => SizedBox(
              height: 170,
              child: controller.playQueue.isEmpty
                  ? Center(
                      child: Text(
                        "No Songs In Play Queue",
                        style: appTextStyle(),
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: controller.playQueue.isEmpty
                          ? 1
                          : controller.playQueue.length,
                      itemBuilder: (BuildContext context, int index) {
                        SongModel song = controller.playQueue[index];
                        if (controller.playQueue.isEmpty) {
                          return Center(
                            child: Text(
                              "No Songs In Play Queue",
                              style: appTextStyle(),
                            ),
                          );
                        } else {
                          return GridSong(
                            song: song,
                            songList: controller.playQueue,
                            controller: controller,
                            index: index,
                            isPlayQueue: true,
                          );
                        }
                      },
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Recently Added',
              textAlign: TextAlign.left,
              style: appTextStyle(size: 16),
            ),
          ),
          Obx(
            () => SizedBox(
              child: controller.allSongs.isEmpty
                  ? SizedBox(
                      height: 200,
                      child: Center(
                        child: Text(
                          "No Recently Added Songs Found",
                          style: appTextStyle(),
                        ),
                      ),
                    )
                  : GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.7,
                      ),
                      shrinkWrap: true,
                      itemCount: controller.recentlyAddedSongs.length,
                      itemBuilder: (BuildContext context, index) {
                        SongModel song = controller.recentlyAddedSongs[index];
                        return GridSong(
                          song: song,
                          songList: controller.recentlyAddedSongs,
                          controller: controller,
                          index: index,
                          isPlayQueue: false,
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
