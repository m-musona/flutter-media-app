import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';

class AudioPlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  var playQueue = <SongModel>[].obs;
  var allSongs = <SongModel>[].obs;
  var recentlyAddedSongs = <SongModel>[].obs;
  var currentlyPlayingSong = Rx<SongModel?>(null);
  var playlists = <PlaylistModel>[].obs;
  var playlistSongs = <SongModel>[].obs;
  var artistSongs = <SongModel>[].obs;
  var albumSongs = <SongModel>[].obs;
  var genreSongs = <SongModel>[].obs;
  var originalList = <SongModel>[].obs;
  var artists = <ArtistModel>[].obs;
  var albums = <AlbumModel>[].obs;
  var genres = <GenreModel>[].obs;

  var playIndex = 0.obs;
  var isPlaying = false.obs;
  var repeatSong = false.obs;
  var repeatPlayQueue = false.obs;
  var isShuffle = false.obs;

  var duration = ''.obs;
  var position = ''.obs;

  var max = 0.0.obs;
  var value = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    checkPermission().then((value) => getSongs());
  }

  repeatSongFunction() {
    repeatSong(true);
    repeatPlayQueue(false);
    print('repeating Song');
  }

  repeatPlayQueueFunction() {
    repeatSong(false);
    repeatPlayQueue(true);
    print('repeating Play Queue');
  }

  normalRepeatFunction() {
    repeatSong(false);
    repeatPlayQueue(false);
    print('No Repeat');
  }

  updatePosition() {
    audioPlayer.durationStream.listen((d) {
      duration.value = d.toString().split('.')[0];
      max.value = d!.inSeconds.toDouble();
    });
    audioPlayer.positionStream.listen((p) {
      position.value = p.toString().split('.')[0];
      value.value = p.inSeconds.toDouble();
    });
  }

  Future getSongs() async {
    allSongs.value = await audioQuery.querySongs(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
      uriType: UriType.EXTERNAL,
    );
    allSongs.removeWhere((songs) => songs.isRingtone == true);
    allSongs.removeWhere((songs) => songs.isNotification == true);
    allSongs.removeWhere((songs) => songs.isAlarm == true);

    allSongs
        .sort((songA, songB) => songB.dateAdded!.compareTo(songA.dateAdded!));
    recentlyAddedSongs.value = allSongs.take(12).toList();
    allSongs.sort((songA, songB) => songA.title.compareTo(songB.title));

    playlists.value = await audioQuery.queryPlaylists(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
      uriType: UriType.EXTERNAL,
    );
    playlists.removeWhere((playlist) => playlist.playlist.contains('_'));
    artists.value = await audioQuery.queryArtists(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
      uriType: UriType.EXTERNAL,
    );
    albums.value = await audioQuery.queryAlbums(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
      uriType: UriType.EXTERNAL,
    );
    genres.value = await audioQuery.queryGenres(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
      uriType: UriType.EXTERNAL,
    );
  }

  Future getSongsFromPlaylist(PlaylistModel queryPlaylist) async {
    playlistSongs.value = await audioQuery.queryAudiosFrom(
      AudiosFromType.PLAYLIST,
      queryPlaylist.id,
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
    );
  }

  Future getSongsFromArtist(ArtistModel queryArtist) async {
    artistSongs.value = await audioQuery.queryAudiosFrom(
      AudiosFromType.ARTIST_ID,
      queryArtist.id,
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
    );
  }

  Future getSongsFromAlbum(AlbumModel queryAlbum) async {
    albumSongs.value = await audioQuery.queryAudiosFrom(
      AudiosFromType.ALBUM_ID,
      queryAlbum.id,
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
    );
  }

  Future getSongsFromGenre(GenreModel queryGenre) async {
    genreSongs.value = await audioQuery.queryAudiosFrom(
      AudiosFromType.GENRE_ID,
      queryGenre.id,
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
    );
  }

  changeDurationToSeconds(data, seconds) {
    var duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  changePlayQueue(List<SongModel>? whereSongIsFrom) {
    playQueue.value = whereSongIsFrom!;
  }

  shufflePlayQueue(int initialSongIndex) {
    SongModel specificElement = playQueue[
        initialSongIndex]; // Element you want to keep as the first one
    if (!isShuffle.value) {
      // Make a copy of the initial list
      originalList.value = List.of(playQueue);
      // Remove the specific element from the list
      playQueue.remove(specificElement);
      // Shuffle the remaining elements
      playQueue.shuffle(Random());
      // Insert the specific element as the first item in the shuffled list
      playQueue.insert(0, specificElement);
      playIndex.value = 0;
      currentlyPlayingSong.value = specificElement;
      isShuffle(true);
    } else {
      // To reset the list to its original state
      playQueue.value = List.of(originalList);
      isShuffle(false);
    }
  }

  playSong(
    SongModel? song,
    String songUri,
    songIndex,
  ) {
    playIndex.value = songIndex;
    try {
      if (song != currentlyPlayingSong.value) {
        audioPlayer.setAudioSource(
          AudioSource.uri(
            Uri.parse(songUri),
          ),
        );
        audioPlayer.play();
        updatePosition();
        isPlaying(true);
        audioPlayer.processingStateStream.listen((state) {
          if (state == ProcessingState.completed) {
            // Audio has finished playing
            if (repeatSong.value) {
              playSong(song, songUri, songIndex);
            } else if (repeatPlayQueue.value) {
              // Check if you've reached the end of the list
              if (playIndex.value == playQueue.length - 1) {
                playSong(playQueue[0], playQueue[0].uri!, 0);
              } else {
                int nextSongIndex = playIndex.value + 1;
                SongModel nextSong = playQueue[nextSongIndex];
                playSong(nextSong, nextSong.uri!, nextSongIndex);
              }
            } else {
              if (playIndex.value == playQueue.length - 1) {
                isPlaying(false);
              } else {
                int nextSongIndex = playIndex.value + 1;
                SongModel nextSong = playQueue[nextSongIndex];
                playSong(nextSong, nextSong.uri!, nextSongIndex);
              }
            }
          }
        });
      }
      currentlyPlayingSong.value = song;
    } on Exception catch (e) {
      print('Playing Song Error "${e.toString()}"');
    }
  }

  afterFinishedPlaying() {}

  checkPermission() async {
    // var newStoragePermission = await Permission.manageExternalStorage.request();

    if (defaultTargetPlatform == TargetPlatform.android) {
      //var photoPermissionStatus = await Permission.photos.status;
      //var videoPermissionStatus = await Permission.videos.status;
      // var isAndroid11OrHigher = await isAndroid11OrHigher();
      Future<bool> isAndroidVersionLessThan11() async {
        final AndroidDeviceInfo androidInfo =
            await DeviceInfoPlugin().androidInfo;
        final String androidVersion = androidInfo.version.release;

        // Split the version string and extract major version number
        final List<String> versionParts = androidVersion.split('.');
        if (versionParts.isNotEmpty) {
          final int majorVersion = int.tryParse(versionParts[0])!;

          // Check if the major version is less than 11
          if (majorVersion < 11) {
            return true;
          }
        }

        return false;
      }

      bool isLowerThanAndroid11 = await isAndroidVersionLessThan11();

      if (!isLowerThanAndroid11) {
        // Handle permissions for Android 11 or higher
        // var audioPermissionStatus = await Permission.audio.status;
        // var videoPermissionStatus = await Permission.videos.status;
        // var photoPermissionStatus = await Permission.photos.status;
        var newStoragePermissionStatus =
            await Permission.manageExternalStorage.status;
        if (newStoragePermissionStatus.isDenied) {
          final status = await Permission.manageExternalStorage.request();
          if (status.isDenied) {
            // Permission denied by the user
            checkPermission();
            // You can show a dialog or message to explain why the permission is required
          } else if (status.isGranted) {
            print("Status Granted");
          }
        }
        // if (videoPermissionStatus.isDenied) {
        //   final status = await Permission.videos.request();
        //   if (status.isDenied) {
        //     // Permission denied by the user
        //     // You can show a dialog or message to explain why the permission is required
        //   }
        // }
        // if (photoPermissionStatus.isDenied) {
        //   final status = await Permission.photos.request();
        //   if (status.isDenied) {
        //     // Permission denied by the user
        //     // You can show a dialog or message to explain why the permission is required
        //   }
        // }
      } else {
        // Handle permissions for Android versions lower than 11
        var oldStoragePermissionStatus = await Permission.storage.status;
        if (oldStoragePermissionStatus.isDenied) {
          final status = await Permission.storage.request();
          if (status.isDenied) {
            // Permission denied by the user
            checkPermission();
            // You can show a dialog or message to explain why the permission is required
          } else if (status.isGranted) {
            print("Status Granted");
          }
        }
      }
    }
  }
}
