import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wework_movies_app/core/helpers/logger/error_reporter.dart';
import 'package:wework_movies_app/core/helpers/shared_preference/pref_helper.dart';
import 'package:wework_movies_app/core/helpers/shared_preference/pref_keys.dart';
import 'package:wework_movies_app/core/utils/we_movies_utils.dart';
import 'package:wework_movies_app/features/home/data/models/image_configuration.dart';
import 'package:wework_movies_app/features/home/data/models/now_playing_movies.dart';
import 'package:wework_movies_app/features/home/data/models/results.dart';
import 'package:wework_movies_app/features/home/data/models/top_rated_movies.dart';
import 'package:wework_movies_app/features/home/data/repository/image_configuration_repository.dart';
import 'package:wework_movies_app/features/home/data/repository/now_playing_movies_repository.dart';
import 'package:wework_movies_app/features/home/data/repository/top_rated_movies_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  NowPlayingMovies nowPlayingMovies = NowPlayingMovies();
  TopRatedMovies topRatedMovies = TopRatedMovies();
  ImageConfiguration imageConfiguration = ImageConfiguration();

  String? targetPosterSize;
  String? baseImageUrl;

  List<Results> nowPlayingMoviesList = [];
  List<Results> topRatedMoviesList = [];

  bool isSearching = false;
  bool noResultFound = false;
  List<Results> searchedNowPlayingMoviesList = [];
  List<Results> searchedTopRatedMoviesList = [];

  int nowPlayingPageNumber = 1;
  int topRatedPageNumber = 1;

  /// this variables will not allow any other request if there is already an
  /// existing request.
  bool _isAlreadyFetchingNowPlaying = false;
  bool _isAlreadyFetchingTopRated = false;

  /// this bool handles the case when we reach at the bottom
  /// of the list. At that point it becomes true.
  bool _shouldPausePaginationForNowPlaying = false;
  bool _shouldPausePaginationForTopRated = false;

  Future<void> fetchMoviesData() async {
    emit(HomeLoading());
    try {
      await Future.wait([
        _getNowPlayingMovies(),
        _getTopRatedMovies(),
        _getImageConfiguration()
      ]).then((value) => _updatePosterUrl());
      emit(HomeInitial());
    } catch (e, st) {
      ErrorReporter.error(e, stackTrace: st, errorMsg: "❌ Error: ");
      emit(HomeError());
    }
  }

  Future<void> _getNowPlayingMovies() async {
    try {
      if (PrefHelper.getJson(PrefKeys.NOW_PLAYING_MOVIES, null) != "" &&
          !(await WeMoviesUtils().isInternetConnected())) {
        nowPlayingMovies = NowPlayingMovies.fromJson(
            PrefHelper.getJson(PrefKeys.NOW_PLAYING_MOVIES, ""));
      } else {
        nowPlayingMovies = await NowPlayingMoviesRepository()
            .fetchNowPlayingMovies(pageNumber: nowPlayingPageNumber);
        nowPlayingPageNumber = 2;
        PrefHelper.setJson(PrefKeys.NOW_PLAYING_MOVIES, nowPlayingMovies);
      }
      nowPlayingMoviesList = nowPlayingMovies.results ?? [];
    } catch (e, st) {
      throw (e, st);
    }
  }

  Future<void> _getTopRatedMovies() async {
    try {
      if (PrefHelper.getJson(PrefKeys.TOP_RATED_MOVIES, null) != "" &&
          !(await WeMoviesUtils().isInternetConnected())) {
        topRatedMovies = TopRatedMovies.fromJson(
            PrefHelper.getJson(PrefKeys.TOP_RATED_MOVIES, ""));
      } else {
        topRatedMovies = await TopRatedMoviesRepository()
            .fetchTopRatedMovies(pageNumber: topRatedPageNumber);
        topRatedPageNumber = 2;
        PrefHelper.setJson(PrefKeys.TOP_RATED_MOVIES, topRatedMovies);
      }
      topRatedMoviesList = topRatedMovies.results ?? [];
    } catch (e, st) {
      throw (e, st);
    }
  }

  Future<void> _getImageConfiguration() async {
    try {
      if (PrefHelper.getJson(PrefKeys.CONFIGURATION, null) != "" &&
          !(await WeMoviesUtils().isInternetConnected())) {
        imageConfiguration = ImageConfiguration.fromJson(
            PrefHelper.getJson(PrefKeys.CONFIGURATION, ""));
      } else {
        imageConfiguration =
            await ImageConfigurationRepository().fetchImageConfiguration();
        PrefHelper.setJson(PrefKeys.CONFIGURATION, imageConfiguration);
      }
      if (imageConfiguration.images!.posterSizes!.length > 3) {
        targetPosterSize = imageConfiguration.images!
            .posterSizes![imageConfiguration.images!.posterSizes!.length - 3];
      } else {
        targetPosterSize = imageConfiguration.images!
            .posterSizes![imageConfiguration.images!.posterSizes!.length - 2];
      }
      baseImageUrl = "${imageConfiguration.images!.baseUrl}$targetPosterSize";
    } catch (e, st) {
      throw (e, st);
    }
  }

  void _updatePosterUrl() {
    for (var result in nowPlayingMoviesList) {
      result.posterPath = (baseImageUrl ?? "") + result.posterPath!;
    }
    for (var result in topRatedMoviesList) {
      result.backdropPath = (baseImageUrl ?? "") + result.backdropPath!;
    }
  }

  Future<void> getPaginationNowPlayingMovies() async {
    if ((_shouldPausePaginationForNowPlaying || _isAlreadyFetchingNowPlaying)) {
      return;
    }
    _isAlreadyFetchingNowPlaying = true;
    emit(NowPlayingPaginationLoading());
    try {
      nowPlayingMovies = await NowPlayingMoviesRepository()
          .fetchNowPlayingMovies(pageNumber: nowPlayingPageNumber);

      var responseList = nowPlayingMovies.results;
      if (responseList != null && responseList.isNotEmpty) {
        for (var result in responseList) {
          result.posterPath = (baseImageUrl ?? "") + (result.posterPath ?? "");
        }
        nowPlayingMoviesList.addAll(responseList);
      }

      nowPlayingPageNumber += 1;

      if (nowPlayingPageNumber >= (nowPlayingMovies.totalPages ?? 1)) {
        _shouldPausePaginationForNowPlaying = true;
      }
    } catch (e, st) {
      ErrorReporter.error(e, stackTrace: st, errorMsg: "❌ Error: ");
    }
    _isAlreadyFetchingNowPlaying = false;
    emit(HomeInitial());
  }

  Future<void> getPaginationTopRatedMovies() async {
    if ((_shouldPausePaginationForTopRated || _isAlreadyFetchingTopRated)) {
      return;
    }
    _isAlreadyFetchingTopRated = true;
    emit(TopRatedPaginationLoading());
    try {
      topRatedMovies = await TopRatedMoviesRepository()
          .fetchTopRatedMovies(pageNumber: topRatedPageNumber);
      PrefHelper.setJson(PrefKeys.TOP_RATED_MOVIES, topRatedMovies);

      var responseList = topRatedMovies.results;
      if (responseList != null && responseList.isNotEmpty) {
        for (var result in responseList) {
          result.backdropPath = (baseImageUrl ?? "") + result.backdropPath!;
        }
        topRatedMoviesList.addAll(responseList);
      }

      topRatedPageNumber += 1;

      if (topRatedPageNumber >= (topRatedMovies.totalPages ?? 1)) {
        _shouldPausePaginationForTopRated = true;
      }
    } catch (e, st) {
      ErrorReporter.error(e, stackTrace: st, errorMsg: "❌ Error: ");
    }
    _isAlreadyFetchingTopRated = false;
    emit(HomeInitial());
  }

  void filterMovies(String query) {
    emit(HomeLoading());
    if (query.isEmpty) {
      isSearching = false;
    } else {
      // Filter movies based on the search query
      isSearching = true;
      searchedNowPlayingMoviesList = nowPlayingMoviesList
          .where((movie) =>
              movie.originalTitle
                  ?.toLowerCase()
                  .contains(query.toLowerCase()) ??
              false)
          .toList();
      searchedTopRatedMoviesList = topRatedMoviesList
          .where((movie) =>
              movie.originalTitle
                  ?.toLowerCase()
                  .contains(query.toLowerCase()) ??
              false)
          .toList();

      noResultFound = searchedNowPlayingMoviesList.isEmpty &&
          searchedTopRatedMoviesList.isEmpty;
    }
    emit(HomeInitial());
  }
}
