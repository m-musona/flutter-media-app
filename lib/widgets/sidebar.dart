import 'package:flutter/material.dart';

import '../consts/colors.dart';
import '../consts/text_style.dart';
import '../controllers/pages_controller.dart';

class NavigationSidebar extends StatelessWidget {
  final PagesController pagesController;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const NavigationSidebar({
    super.key,
    required this.pagesController,
    required this.scaffoldKey,
  });

  final double iconSize = 40;
  final double orangeIconSize = 25;

  @override
  Widget build(BuildContext context) {
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
                  pagesController.currentPageIndex.value = 0;
                  scaffoldKey.currentState?.closeDrawer();
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
                  pagesController.currentPageIndex.value = 1;
                  scaffoldKey.currentState?.closeDrawer();
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
                  pagesController.currentPageIndex.value = 2;
                  scaffoldKey.currentState?.closeDrawer();
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
                  pagesController.currentPageIndex.value = 3;
                  scaffoldKey.currentState?.closeDrawer();
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
                  pagesController.currentPageIndex.value = 4;
                  scaffoldKey.currentState?.closeDrawer();
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
                  pagesController.currentPageIndex.value = 5;
                  scaffoldKey.currentState?.closeDrawer();
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
                  pagesController.currentPageIndex.value = 6;
                  scaffoldKey.currentState?.closeDrawer();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
