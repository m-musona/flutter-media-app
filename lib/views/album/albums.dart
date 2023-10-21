import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../consts/colors.dart';
import '../../consts/text_style.dart';
import '../../controllers/audio_player_controller.dart';
import '../../widgets/grid_album.dart';
import '../../widgets/sidebar.dart';

class AlbumsView extends StatelessWidget {
  const AlbumsView({super.key});

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
      body: controller.allSongs.isEmpty
          ? SizedBox(
              height: 200,
              child: Center(
                child: Text(
                  "No Albums Found",
                  style: appTextStyle(),
                ),
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              shrinkWrap: true,
              itemCount: controller.albums.length,
              itemBuilder: (BuildContext context, index) {
                controller.albums.sort(
                    (albumA, albumB) => albumA.album.compareTo(albumB.album));
                AlbumModel album = controller.albums[index];
                return GridAlbum(
                  album: album,
                  controller: controller,
                );
              },
            ),
    );
  }
}
