import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fiu/model/models.dart';
import 'package:fiu/services/services.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is GetMovies) {
      List<Movie> movies = await MovieServices.getMovies(1);
      List<Movie> upComingMovies = await MovieServices.getUpComingMovies(2);

      yield MovieLoaded(
        movies: movies,
        upComingMovies: upComingMovies,
      );
    }
  }
}
