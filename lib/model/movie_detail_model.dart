part of 'models.dart';

class MovieDetail extends Movie {
  final List<String> genres;
  final String releaseDate;
  final int duration;

  MovieDetail(Movie movie, {this.genres, this.releaseDate, this.duration})
      : super(
            id: movie.id,
            title: movie.title,
            voteAverage: movie.voteAverage,
            overview: movie.overview,
            adult: movie.adult,
            popularity: movie.popularity,
            posterPath: movie.posterPath,
            backdropPath: movie.backdropPath);

  String get yearDurationGenres {
    String g = '';

    for (var genre in genres) {
      g += genre + (genre == genres.last ? "" : ", ");
    }

    return "${releaseDate.split('-')[0]} | $g | ${duration.toString()} min";
  }

  @override
  List<Object> get props => super.props + [genres, releaseDate, duration];
}
