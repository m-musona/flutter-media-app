import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../consts/text_style.dart';
import '../../controllers/audio_player_controller.dart';
import '../../widgets/grid_album.dart';

class AlbumsView extends StatelessWidget {
  final AudioPlayerController controller;
  const AlbumsView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return controller.allSongs.isEmpty
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
          );
  }
}
