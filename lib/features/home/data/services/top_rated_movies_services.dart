import 'package:wework_movies_app/core/helpers/api_helpers/api_call_helpers.dart';
import 'package:wework_movies_app/core/web_services/api_urls.dart';

class TopRatedMoviesServices {
  final ApiCallHelper _apiCallHelper = ApiCallHelper();

  Future<dynamic> fetchTopRatedMovies(int pageNumber) async {
    var response = await _apiCallHelper
        .get("${ApiEndPoint.TOP_RATED_MOVIES_ENDPOINT}page=$pageNumber");

    return response;
  }
}
