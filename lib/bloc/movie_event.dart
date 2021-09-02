part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class GetMovies extends MovieEvent {
  @override
  List<Object> get props => [];
}
