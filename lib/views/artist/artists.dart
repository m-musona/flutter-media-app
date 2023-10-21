import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../consts/colors.dart';
import '../../consts/text_style.dart';
import '../../controllers/audio_player_controller.dart';
import '../../widgets/list_artist.dart';
import '../../widgets/sidebar.dart';

class ArtistsView extends StatelessWidget {
  const ArtistsView({super.key});

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
      body: controller.artists.isEmpty
          ? Center(
              child: Text(
                "No Artists Found",
                style: appTextStyle(),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: controller.artists.length,
              itemBuilder: (BuildContext context, int index) {
                ArtistModel artist = controller.artists[index];
                return ListArtist(
                  artist: artist,
                  controller: controller,
                );
              },
            ),
    );
  }
}
