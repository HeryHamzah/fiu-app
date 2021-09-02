part of "services.dart";

class MovieServices {
  static Future<List<Movie>> getMovies(int page, {http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page&with_watch_monetization_types=flatrate";

    client ??= http.Client();
    var response = await client.get(url);

    if (response.statusCode != 200) {
      return [];
    }

    var data = jsonDecode(response.body);
    List result = data['results'];

    return result.map((e) => Movie.fromJson(e)).toList();
  }

  static Future<List<Movie>> getUpComingMovies(int page,
      {http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey&language=en-US&page=$page";

    client ??= http.Client();
    var response = await client.get(url);

    if (response.statusCode != 200) {
      return [];
    }

    var data = jsonDecode(response.body);
    List result = data['results'];

    return result.map((e) => Movie.fromJson(e)).take(8).toList();
  }

  static Future<MovieDetail> getDetailMovies(Movie movie,
      {int movieID, http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/movie/${movieID ?? movie.id}?api_key=$apiKey&language=en-US";

    client ??= http.Client();
    var response = await client.get(url);

    if (response.statusCode != 200) {
      return null;
    }

    var data = jsonDecode(response.body);
    List genres = (data as Map<String, dynamic>)['genres'];

    return (movie == null)
        ? MovieDetail(Movie.fromJson(data),
            genres: genres
                .map((e) => (e as Map<String, dynamic>)['name'].toString())
                .toList(),
            duration: (data as Map<String, dynamic>)['runtime'],
            releaseDate: (data as Map<String, dynamic>)['release_date'])
        : MovieDetail(movie,
            genres: genres
                .map((e) => (e as Map<String, dynamic>)['name'].toString())
                .toList(),
            duration: (data as Map<String, dynamic>)['runtime'],
            releaseDate: (data as Map<String, dynamic>)['release_date']);
  }

  static Future<List<Credits>> getCredits(int movieID,
      {http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/movie/$movieID/credits?api_key=$apiKey&language=en-US";

    client ??= http.Client();
    var response = await client.get(url);

    if (response.statusCode != 200) {
      return [];
    }
    var data = jsonDecode(response.body);
    List cast = (data as Map<String, dynamic>)['cast'];

    return cast
        .map((e) => Credits(
            name: (e as Map<String, dynamic>)['name'],
            profilePath: (e as Map<String, dynamic>)['profile_path'],
            character: (e as Map<String, dynamic>)['character']))
        .take(8)
        .toList();
  }
}
