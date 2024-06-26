import 'package:wework_movies_app/features/home/data/models/results.dart';

class TopRatedMovies {
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;

  TopRatedMovies({this.page, this.results, this.totalPages, this.totalResults});

  TopRatedMovies.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}
