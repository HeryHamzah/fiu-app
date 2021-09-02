part of 'models.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final double voteAverage;
  final String overview;
  final bool adult;
  final double popularity;
  final String backdropPath;
  final String posterPath;

  Movie({
    @required this.id,
    @required this.title,
    @required this.voteAverage,
    @required this.overview,
    @required this.adult,
    @required this.popularity,
    @required this.backdropPath,
    @required this.posterPath,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
      id: json['id'],
      title: json['title'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      overview: json['overview'],
      adult: json['adult'],
      popularity: (json['popularity'] as num).toDouble(),
      backdropPath: json['backdrop_path'],
      posterPath: json['poster_path']);

  @override
  List<Object> get props => [
        id,
        title,
        voteAverage,
        overview,
        adult,
        popularity,
        backdropPath,
        posterPath
      ];
}
