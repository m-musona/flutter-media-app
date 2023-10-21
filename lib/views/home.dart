import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../consts/colors.dart';
import '../consts/text_style.dart';
import '../controllers/audio_player_controller.dart';
import '../widgets/grid_song.dart';
import '../widgets/sidebar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    var controller = Get.put(AudioPlayerController());

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
      body: SingleChildScrollView(
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
            SizedBox(
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
                      itemCount: controller.playQueue.length,
                      itemBuilder: (BuildContext context, int index) {
                        SongModel song = controller.playQueue[index];
                        return GridSong(song: song);
                      },
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
            controller.allSongs.isEmpty
                ? SizedBox(
                    height: 200,
                    child: Center(
                      child: Text(
                        "No Songs Found",
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
                    itemCount: 12,
                    itemBuilder: (BuildContext context, index) {
                      List<SongModel> recentlyAddedsong = controller.allSongs;
                      recentlyAddedsong.sort((songA, songB) =>
                          songB.dateAdded!.compareTo(songA.dateAdded!));
                      SongModel song = recentlyAddedsong[index];
                      return GridSong(song: song);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
