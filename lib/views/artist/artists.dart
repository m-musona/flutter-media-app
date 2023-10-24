import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../consts/text_style.dart';
import '../../controllers/audio_player_controller.dart';
import '../../widgets/list_artist.dart';

class ArtistsView extends StatelessWidget {
  final AudioPlayerController controller;
  const ArtistsView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: controller.artists.isEmpty
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
