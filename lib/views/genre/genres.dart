import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../consts/colors.dart';
import '../../consts/text_style.dart';
import '../../controllers/audio_player_controller.dart';
import '../../widgets/list_genre.dart';
import '../../widgets/sidebar.dart';

class GenresView extends StatelessWidget {
  const GenresView({super.key});

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
      body: controller.genres.isEmpty
          ? Center(
              child: Text(
                "No Genres Found",
                style: appTextStyle(),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: controller.genres.length,
              itemBuilder: (BuildContext context, int index) {
                GenreModel genre = controller.genres[index];
                return ListGenre(
                  genre: genre,
                  controller: controller,
                );
              },
            ),
    );
  }
}
