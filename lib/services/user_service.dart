part of 'services.dart';

class UserServices {
  static CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> updateUser(User user) async {
    await _userCollection.doc(user.id).set({
      'email': user.email,
      'name': user.name,
      'balance': user.balance,
      'selectedGenres': user.selectedGenres,
      'selectedYear': user.selectedYear,
      'profilePicture': user.profilePicture ?? "",
      'favoriteMovies': user.favoriteMovies
    });
  }

  static Future<User> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.doc(id).get();

    return User(id, snapshot.data()['email'],
        name: snapshot.data()['name'],
        balance: snapshot.data()['balance'],
        selectedGenres: (snapshot.data()['selectedGenres'] as List)
            .map((e) => e.toString())
            .toList(),
        selectedYear: snapshot.data()['selectedYear'],
        profilePicture: snapshot.data()['profilePicture'],
        favoriteMovies: (snapshot.data()['favoriteMovies'] as List)
            .map((e) => e as num)
            .toList());
  }

  static Future<List<Movie>> getFavoriteMovies(String userID) async {
    DocumentSnapshot snapshots = await _userCollection.doc(userID).get();

    List<Movie> favoriteMovies = [];

    for (var snapshot in snapshots.data()['favoriteMovies']) {
      MovieDetail movieDetail =
          await MovieServices.getDetailMovies(null, movieID: snapshot);

      favoriteMovies.add(Movie(
          id: movieDetail.id,
          title: movieDetail.title,
          voteAverage: movieDetail.voteAverage,
          overview: movieDetail.overview,
          adult: movieDetail.adult,
          popularity: movieDetail.popularity,
          backdropPath: movieDetail.backdropPath,
          posterPath: movieDetail.posterPath));
    }

    return favoriteMovies;
  }
}
