import 'package:wework_movies_app/features/home/data/models/image_configuration.dart';
import 'package:wework_movies_app/features/home/data/services/image_configuration_services.dart';

class ImageConfigurationRepository {
  final ImageConfigurationServices _imageConfigurationServices =
      ImageConfigurationServices();

  Future<ImageConfiguration> fetchImageConfiguration() async {
    var response = await _imageConfigurationServices.fetchImageConfiguration();

    return ImageConfiguration.fromJson(response);
  }
}
