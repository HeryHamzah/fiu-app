part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();
}

class MovieInitial extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieLoaded extends MovieState {
  final List<Movie> movies;
  final List<Movie> upComingMovies;

  MovieLoaded({this.movies, this.upComingMovies});
  @override
  List<Object> get props => [movies, upComingMovies];
}
