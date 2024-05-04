import 'package:wework_movies_app/core/helpers/api_helpers/api_call_helpers.dart';
import 'package:wework_movies_app/core/web_services/api_urls.dart';

class ImageConfigurationServices {
  final ApiCallHelper _apiCallHelper = ApiCallHelper();

  Future<dynamic> fetchImageConfiguration() async {
    var response =
        await _apiCallHelper.get(ApiEndPoint.IMAGE_CONFIGURATION_ENDPOINT);

    return response;
  }
}
