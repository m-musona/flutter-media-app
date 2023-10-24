import 'package:flutter/material.dart';
import 'package:flutter_media_app/consts/colors.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../consts/text_style.dart';
import '../controllers/audio_player_controller.dart';
import '../views/audio_player.dart';

class BottomPlayer extends StatelessWidget {
  final AudioPlayerController audioController;
  const BottomPlayer({
    super.key,
    required this.audioController,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = 85;
    return Container(
      width: width,
      height: height,
      color: backgroundColor,
      child: Column(
        children: [
          Obx(
            () => audioController.currentlyPlayingSong.value == null
                ? const SizedBox()
                : SizedBox(
                    width: width,
                    child: LinearProgressIndicator(
                      backgroundColor: backgroundColor,
                      color: sliderColor,
                      value: audioController.value.value /
                          audioController.max.value,
                    ),
                  ),
          ),
          Expanded(
            child: Row(
              children: [
                Obx(
                  () => SizedBox(
                    child: audioController.currentlyPlayingSong.value == null
                        ? Icon(
                            Icons.music_note,
                            color: disabledColor,
                            size: height - 5,
                          )
                        : GestureDetector(
                            onTap: () {
                              Get.to(
                                AudioPlayerScreen(controller: audioController),
                                transition: Transition.downToUp,
                              );
                            },
                            child: QueryArtworkWidget(
                              id: audioController
                                  .currentlyPlayingSong.value!.id,
                              artworkBorder: BorderRadius.zero,
                              artworkHeight: height - 5,
                              artworkWidth: height - 5,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: Icon(
                                Icons.music_note,
                                color: whiteColor,
                                size: height,
                              ),
                            ),
                          ),
                  ),
                ),
                Obx(
                  () => audioController.currentlyPlayingSong.value == null
                      ? SizedBox(
                          width: width / 6,
                        )
                      : GestureDetector(
                          onTap: () {
                            Get.to(
                              AudioPlayerScreen(controller: audioController),
                              transition: Transition.downToUp,
                            );
                          },
                          child: SizedBox(
                            width: width / 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  audioController
                                      .currentlyPlayingSong.value!.title,
                                  style: appTextStyle(size: 15),
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  audioController
                                      .currentlyPlayingSong.value!.artist!,
                                  style: appTextStyle(size: 10),
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    children: [
                      Obx(
                        () => IconButton(
                          disabledColor: disabledColor,
                          color: whiteColor,
                          iconSize: 30,
                          padding: const EdgeInsets.all(0),
                          onPressed: audioController
                                      .currentlyPlayingSong.value ==
                                  null
                              ? null
                              : () {
                                  audioController.playSong(
                                    audioController.playQueue[
                                        audioController.playIndex.value - 1],
                                    audioController
                                        .playQueue[
                                            audioController.playIndex.value - 1]
                                        .uri!,
                                    audioController.playIndex.value - 1,
                                  );
                                },
                          icon: const Icon(
                            Icons.skip_previous_rounded,
                          ),
                        ),
                      ),
                      Obx(
                        () => IconButton(
                          disabledColor: disabledColor,
                          padding: const EdgeInsets.all(0),
                          color: whiteColor,
                          iconSize: 40,
                          onPressed:
                              audioController.currentlyPlayingSong.value == null
                                  ? null
                                  : () {
                                      if (audioController.isPlaying.value) {
                                        audioController.audioPlayer.pause();
                                        audioController.isPlaying(false);
                                      } else {
                                        audioController.audioPlayer.play();
                                        audioController.isPlaying(true);
                                      }
                                    },
                          icon: audioController.isPlaying.value
                              ? const Icon(
                                  Icons.pause_circle_outline_rounded,
                                )
                              : const Icon(
                                  Icons.play_circle_outline_rounded,
                                ),
                        ),
                      ),
                      Obx(
                        () => IconButton(
                          disabledColor: disabledColor,
                          color: whiteColor,
                          iconSize: 30,
                          padding: const EdgeInsets.all(0),
                          onPressed: audioController
                                      .currentlyPlayingSong.value ==
                                  null
                              ? null
                              : () {
                                  audioController.playSong(
                                    audioController.playQueue[
                                        audioController.playIndex.value + 1],
                                    audioController
                                        .playQueue[
                                            audioController.playIndex.value + 1]
                                        .uri!,
                                    audioController.playIndex.value + 1,
                                  );
                                },
                          icon: const Icon(
                            Icons.skip_next_rounded,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
