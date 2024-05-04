import 'package:wework_movies_app/features/home/data/models/top_rated_movies.dart';
import 'package:wework_movies_app/features/home/data/services/top_rated_movies_services.dart';

class TopRatedMoviesRepository {
  final TopRatedMoviesServices _topRatedMoviesServices =
      TopRatedMoviesServices();

  Future<TopRatedMovies> fetchTopRatedMovies({int? pageNumber}) async {
    var response =
        await _topRatedMoviesServices.fetchTopRatedMovies(pageNumber ?? 1);

    return TopRatedMovies.fromJson(response);
  }
}
