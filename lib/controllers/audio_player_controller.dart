import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioPlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  var playQueue = <SongModel>[].obs;
  var allSongs = <SongModel>[].obs;
  var recentlyAddedSongs = <SongModel>[].obs;
  var currentlyPlayingSong = Rx<SongModel?>(null);
  var playlists = <PlaylistModel>[].obs;
  var playlist = <SongModel>[].obs;
  var artistSongs = <SongModel>[].obs;
  var albumSongs = <SongModel>[].obs;
  var genreSongs = <SongModel>[].obs;
  var artists = <ArtistModel>[].obs;
  var albums = <AlbumModel>[].obs;
  var genres = <GenreModel>[].obs;

  var playIndex = 0.obs;
  var isPlaying = false.obs;

  var duration = ''.obs;
  var position = ''.obs;

  var max = 0.0.obs;
  var value = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    checkPermission();
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
    playlist.value = await audioQuery.queryAudiosFrom(
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
      }
      currentlyPlayingSong.value = song;
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  checkPermission() async {
    var permission = await Permission.storage.request();
    if (permission.isGranted) {
    } else {
      checkPermission();
    }
  }
}
