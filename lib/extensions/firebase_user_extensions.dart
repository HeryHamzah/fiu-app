part of 'extensions.dart';

extension FirebaseUserExtensions on auth.User {
  User convertToUser(
          {String name = "No Name",
          List<String> selectedGenres = const [],
          String selectedYear = "Latest Movies",
          int balance = 0,
          List<num> favoriteMovies = const []}) =>
      User(this.uid, this.email,
          name: name,
          selectedGenres: selectedGenres,
          selectedYear: selectedYear,
          balance: balance,
          favoriteMovies: favoriteMovies);

  Future<User> fromFirestore() async => await UserServices.getUser(this.uid);
}
