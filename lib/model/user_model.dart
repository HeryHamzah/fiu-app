part of 'models.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String profilePicture;
  final List<String> selectedGenres;
  final String selectedYear;
  final int balance;
  final List<num> favoriteMovies;

  User(this.id, this.email,
      {this.name,
      this.profilePicture,
      this.selectedGenres,
      this.selectedYear,
      this.balance,
      this.favoriteMovies});

  User copyWith(
          {String name,
          String profilePicture,
          List<String> selectedGenre,
          String selectedYear,
          int balance,
          List<num> favoriteMovies}) =>
      User(this.id, this.email,
          name: name ?? this.name,
          profilePicture: profilePicture ?? this.profilePicture,
          selectedGenres: this.selectedGenres,
          selectedYear: this.selectedYear,
          balance: balance ?? this.balance,
          favoriteMovies: favoriteMovies ?? this.favoriteMovies);
  @override
  List<Object> get props => [
        id,
        email,
        name,
        profilePicture,
        selectedGenres,
        selectedYear,
        balance,
        favoriteMovies
      ];
}
