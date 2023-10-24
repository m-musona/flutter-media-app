import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../consts/colors.dart';
import '../consts/text_style.dart';
import '../controllers/audio_player_controller.dart';
import 'audio_details.dart';

class AudioPlayerScreen extends StatelessWidget {
  final AudioPlayerController controller;
  const AudioPlayerScreen({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => AudioDetailsView(
                  data: controller.playQueue[controller.playIndex.value],
                ),
                transition: Transition.downToUp,
              );
            },
            icon: const Icon(
              Icons.more_vert,
              color: whiteColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(
          children: [
            Obx(
              () => QueryArtworkWidget(
                id: controller.playQueue[controller.playIndex.value].albumId!,
                artworkBorder: BorderRadius.zero,
                controller: controller.audioQuery,
                artworkHeight: 350,
                artworkWidth: 350,
                size: 350,
                format: ArtworkFormat.PNG,
                quality: 100,
                type: ArtworkType.ALBUM,
                nullArtworkWidget: const Icon(
                  Icons.music_note,
                  color: whiteColor,
                  size: 350,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Obx(
                  () => Column(
                    children: [
                      Text(
                        controller.playQueue[controller.playIndex.value]
                            .displayNameWOExt,
                        style: appTextStyle(
                          color: backgroundDarkColor,
                          size: 18,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        controller.playQueue[controller.playIndex.value].artist!
                            .toString(),
                        style: appTextStyle(
                          color: backgroundDarkColor,
                          size: 14,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 12),
                      Obx(
                        () => Row(
                          children: [
                            Text(
                              controller.position.value,
                              style: appTextStyle(color: backgroundDarkColor),
                            ),
                            Expanded(
                              child: Slider(
                                thumbColor: sliderColor,
                                inactiveColor: backgroundColor,
                                activeColor: sliderColor,
                                min: const Duration(seconds: 0)
                                    .inSeconds
                                    .toDouble(),
                                max: controller.max.value,
                                value: controller.value.value,
                                onChanged: (newValue) {
                                  controller.changeDurationToSeconds(
                                    controller.playQueue,
                                    newValue.toInt(),
                                  );
                                  newValue = newValue;
                                },
                              ),
                            ),
                            Text(
                              controller.duration.value,
                              style: appTextStyle(color: backgroundDarkColor),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.shuffle_rounded,
                              size: 30,
                              color: Colors.black54,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.playSong(
                                controller
                                    .playQueue[controller.playIndex.value - 1],
                                controller
                                    .playQueue[controller.playIndex.value - 1]
                                    .uri!,
                                controller.playIndex.value - 1,
                              );
                            },
                            icon: const Icon(
                              Icons.skip_previous_rounded,
                              size: 40,
                              color: backgroundDarkColor,
                            ),
                          ),
                          Obx(
                            () => CircleAvatar(
                              radius: 35,
                              backgroundColor: backgroundDarkColor,
                              child: IconButton(
                                onPressed: () {
                                  if (controller.isPlaying.value) {
                                    controller.audioPlayer.pause();
                                    controller.isPlaying(false);
                                  } else {
                                    controller.audioPlayer.play();
                                    controller.isPlaying(true);
                                  }
                                },
                                icon: controller.isPlaying.value
                                    ? const Icon(
                                        Icons.pause,
                                        size: 54,
                                        color: whiteColor,
                                      )
                                    : const Icon(
                                        Icons.play_arrow_rounded,
                                        size: 54,
                                        color: whiteColor,
                                      ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.playSong(
                                controller
                                    .playQueue[controller.playIndex.value + 1],
                                controller
                                    .playQueue[controller.playIndex.value + 1]
                                    .uri!,
                                controller.playIndex.value + 1,
                              );
                            },
                            icon: const Icon(
                              Icons.skip_next_rounded,
                              size: 40,
                              color: backgroundDarkColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.repeat,
                              size: 30,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
