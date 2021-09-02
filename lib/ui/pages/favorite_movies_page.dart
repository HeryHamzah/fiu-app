part of 'pages.dart';

class FavoriteMoviesPage extends StatefulWidget {
  @override
  _FavoriteMoviesPageState createState() => _FavoriteMoviesPageState();
}

class _FavoriteMoviesPageState extends State<FavoriteMoviesPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToProfilePage());
        return;
      },
      child: Scaffold(
          backgroundColor: backColor,
          body: SafeArea(
            child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: defaultMargin, vertical: 20),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        InkWell(
                            onTap: () {
                              context.bloc<PageBloc>().add(GoToProfilePage());
                            },
                            child: Icon(Icons.arrow_back_ios,
                                color: Colors.white)),
                        Center(
                            child: Text("Favorites",
                                style: themeFont.copyWith(fontSize: 20)))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, userState) {
                        return FutureBuilder(
                          future: UserServices.getFavoriteMovies(
                              (userState as UserLoaded).user.id),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            List<Movie> favMovies = snapshot.data;

                            return (snapshot.hasData)
                                ? Expanded(
                                    child: generateFavoriteMovies(
                                        context, favMovies))
                                : Center(
                                    child: SpinKitChasingDots(
                                        color: mainColor, size: 50));
                          },
                        );
                      },
                    ),
                  ],
                )),
          )),
    );
  }

  StaggeredGridView generateFavoriteMovies(
      BuildContext context, List<Movie> favMovies) {
    return StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 12,
        itemCount: favMovies.length,
        itemBuilder: (context, i) {
          return FavoriteMovieCard(
            favMovies[i],
            onTap: () {
              context.bloc<PageBloc>().add(GoToMovieDetailPage(
                  movie: favMovies[i], pageEvent: GoToFavoriteMoviesPage()));
            },
          );
        },
        staggeredTileBuilder: (index) {
          return StaggeredTile.count(1, index.isEven ? 1.5 : 1.8);
        });
  }
}
