import 'package:flutter/material.dart';

import '../consts/colors.dart';
import '../consts/text_style.dart';
import '../widgets/sidebar.dart';

class PlaylistsView extends StatelessWidget {
  const PlaylistsView({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Text(
          'Playlists',
          style: appTextStyle(size: 15),
        ),
      ),
    );
  }
}
