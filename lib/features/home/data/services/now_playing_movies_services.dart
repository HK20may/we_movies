import 'package:wework_movies_app/core/helpers/api_helpers/api_call_helpers.dart';
import 'package:wework_movies_app/core/web_services/api_urls.dart';

class NowPlayingMoviesServices {
  final ApiCallHelper _apiCallHelper = ApiCallHelper();

  Future<dynamic> fetchNowPlayingMovies(int pageNumber) async {
    var response = await _apiCallHelper
        .get("${ApiEndPoint.NOW_PLAYING_MOVIES_ENDPOINT}page=$pageNumber");

    return response;
  }
}
