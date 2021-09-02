import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fiu/model/models.dart';
import 'package:fiu/services/services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoadUser) {
      User user = await UserServices.getUser(event.id);

      yield UserLoaded(user);
    } else if (event is UserSignOut) {
      yield UserInitial();
    } else if (event is UpdateUser) {
      try {
        User updatedUser = (state as UserLoaded)
            .user
            .copyWith(name: event.name, profilePicture: event.profilePicture);

        await UserServices.updateUser(updatedUser);

        yield UserLoaded(updatedUser);
      } catch (e) {
        print(e);
      }
    } else if (event is TopUp) {
      User updatedUser = (state as UserLoaded)
          .user
          .copyWith(balance: (state as UserLoaded).user.balance + event.amount);

      await UserServices.updateUser(updatedUser);

      yield UserLoaded(updatedUser);
    } else if (event is Purchase) {
      User updatedUser = (state as UserLoaded)
          .user
          .copyWith(balance: (state as UserLoaded).user.balance - event.amount);

      await UserServices.updateUser(updatedUser);

      yield UserLoaded(updatedUser);
    } else if (event is AddFavorite) {
      User updatedUser = (state as UserLoaded).user.copyWith(
          favoriteMovies:
              (state as UserLoaded).user.favoriteMovies + [event.movieID]);

      await UserServices.updateUser(updatedUser);

      yield UserLoaded(updatedUser);
    } else if (event is RemoveFavorite) {
      List<num> favMovies = (state as UserLoaded).user.favoriteMovies;

      favMovies.remove(event.movieID);

      User updatedUser =
          (state as UserLoaded).user.copyWith(favoriteMovies: favMovies);

      await UserServices.updateUser(updatedUser);

      yield UserLoaded(updatedUser);
    }
  }
}
