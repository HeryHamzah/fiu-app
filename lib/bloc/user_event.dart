part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoadUser extends UserEvent {
  final String id;

  LoadUser(this.id);

  @override
  List<Object> get props => [id];
}

class UserSignOut extends UserEvent {
  @override
  List<Object> get props => [];
}

class UpdateUser extends UserEvent {
  final String name;
  final String profilePicture;

  UpdateUser({this.name, this.profilePicture});
  @override
  List<Object> get props => [name, profilePicture];
}

class TopUp extends UserEvent {
  final int amount;

  TopUp(this.amount);

  @override
  List<Object> get props => [amount];
}

class Purchase extends UserEvent {
  final int amount;

  Purchase(this.amount);

  @override
  List<Object> get props => [amount];
}

class AddFavorite extends UserEvent {
  final num movieID;

  AddFavorite(this.movieID);

  @override
  List<Object> get props => [movieID];
}

class RemoveFavorite extends UserEvent {
  final num movieID;

  RemoveFavorite(this.movieID);

  @override
  List<Object> get props => [movieID];
}
