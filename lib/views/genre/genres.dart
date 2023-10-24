import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../consts/text_style.dart';
import '../../controllers/audio_player_controller.dart';
import '../../widgets/list_genre.dart';

class GenresView extends StatelessWidget {
  final AudioPlayerController controller;
  const GenresView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: controller.genres.isEmpty
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
