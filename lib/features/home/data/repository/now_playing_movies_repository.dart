import 'package:wework_movies_app/features/home/data/models/now_playing_movies.dart';
import 'package:wework_movies_app/features/home/data/services/now_playing_movies_services.dart';

class NowPlayingMoviesRepository {
  final NowPlayingMoviesServices _nowPlayingMoviesServices =
      NowPlayingMoviesServices();

  Future<NowPlayingMovies> fetchNowPlayingMovies({int? pageNumber}) async {
    var response =
        await _nowPlayingMoviesServices.fetchNowPlayingMovies(pageNumber ?? 1);

    return NowPlayingMovies.fromJson(response);
  }
}
