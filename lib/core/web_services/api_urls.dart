// ignore_for_file: constant_identifier_names

class ApiUrls {
  static const String baseUrl = 'https://api.themoviedb.org/3/';
}

class ApiEndPoint {
  static const String NOW_PLAYING_MOVIES_ENDPOINT =
      "movie/now_playing?language=en-US&";
  static const String TOP_RATED_MOVIES_ENDPOINT =
      "movie/top_rated?language=en-US&";
  static const String IMAGE_CONFIGURATION_ENDPOINT = "configuration";
}
