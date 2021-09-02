part of 'pages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: SafeArea(
        child: ListView(
          children: [
            //note: HEADER
            Container(
              padding:
                  EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 20),
              child: BlocBuilder<UserBloc, UserState>(
                builder: (_, userState) {
                  if (userState is UserLoaded) {
                    if (imageToUpload != null) {
                      uploadImageToFirebaseStorage(imageToUpload)
                          .then((downloadURL) {
                        imageToUpload = null;
                        context
                            .bloc<UserBloc>()
                            .add(UpdateUser(profilePicture: downloadURL));
                      });
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                  child: Text("Hello,",
                                      style: themeFont.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width -
                                      2 * defaultMargin -
                                      50 -
                                      40 -
                                      16,
                                  child: Text(
                                    "${userState.user.name}!",
                                    style: themeFont.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 1),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width -
                                  2 * defaultMargin -
                                  40 -
                                  16,
                              child: Text(
                                NumberFormat.currency(
                                        locale: "id_ID",
                                        decimalDigits: 0,
                                        symbol: "IDR ")
                                    .format(userState.user.balance),
                                style: themeFont.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            context.bloc<PageBloc>().add(GoToProfilePage());
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: (userState.user.profilePicture ==
                                    "")
                                ? AssetImage("assets/profile.png")
                                : NetworkImage(userState.user.profilePicture),
                          ),
                        )
                      ],
                    );
                  } else {
                    return SpinKitChasingDots(color: mainColor, size: 50);
                  }
                },
              ),
            ),

            //note: FOR YOU
            Container(
              margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 10),
              child: Text(
                "For You",
                style: themeFont.copyWith(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            BlocBuilder<MovieBloc, MovieState>(
              builder: (_, movieState) {
                if (movieState is MovieLoaded) {
                  List<Movie> movies = movieState.movies.sublist(0, 10);

                  return Container(
                    // color: mainColor,
                    child: CarouselSlider(
                      carouselController: _carouselController,
                      items: movies
                          .map((e) => InkWell(
                              onTap: () {
                                context.bloc<PageBloc>().add(
                                    GoToMovieDetailPage(
                                        movie: e, pageEvent: GoToMainPage()));
                              },
                              child: CarouselCard(e)))
                          .toList(),
                      options: CarouselOptions(
                          initialPage: _current,
                          height: 300,
                          autoPlay: true,
                          autoPlayCurve: Curves.easeIn,
                          enlargeCenterPage: true,
                          viewportFraction: 0.5,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayInterval: Duration(seconds: 5),
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                    ),
                  );
                }
                return Container(
                  height: 300,
                  child: SpinKitChasingDots(
                    size: 50,
                    color: mainColor,
                  ),
                );
              },
            ),

            //note: FAVORITE CATEGORY
            Container(
              margin: EdgeInsets.fromLTRB(defaultMargin, 15, defaultMargin, 10),
              child: Text(
                "Favorite Category",
                style: themeFont.copyWith(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (_, userState) {
                if (userState is UserLoaded) {
                  List<String> categories = userState.user.selectedGenres;

                  // return Container(
                  //   margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: List.generate(categories.length,
                  //         (i) => CategoryCard(categories[i])),
                  //   ),
                  // );

                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 16,
                      runSpacing: 16,
                      children: List.generate(categories.length,
                          (i) => CategoryCard(categories[i])),
                    ),
                  );
                } else {
                  return Container(
                    height: 50,
                  );
                }
              },
            ),

            //note: NOW IN CINEMAS
            Container(
              margin: EdgeInsets.fromLTRB(defaultMargin, 15, defaultMargin, 10),
              child: Text(
                "Now In Cinemas",
                style: themeFont.copyWith(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            BlocBuilder<MovieBloc, MovieState>(
              builder: (_, movieState) {
                if (movieState is MovieLoaded) {
                  List<Movie> movies = movieState.movies.sublist(10);

                  return Container(
                    height: 140,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movies.length,
                        itemBuilder: (context, i) {
                          return Container(
                              margin: EdgeInsets.only(
                                  left: (i == 0) ? defaultMargin : 0,
                                  right: (i == movies.length - 1)
                                      ? defaultMargin
                                      : 16),
                              child: InkWell(
                                  onTap: () async {
                                    context.bloc<PageBloc>().add(
                                        GoToMovieDetailPage(
                                            movie: movies[i],
                                            pageEvent: GoToMainPage()));
                                  },
                                  child: MovieCard(movies[i])));
                        }),
                  );
                } else {
                  return Container(
                      height: 140,
                      child: SpinKitChasingDots(color: mainColor, size: 50));
                }
              },
            ),

            //note: COMING SOON
            Container(
              margin: EdgeInsets.fromLTRB(defaultMargin, 15, defaultMargin, 10),
              child: Text(
                "Coming Soon",
                style: themeFont.copyWith(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            BlocBuilder<MovieBloc, MovieState>(
              builder: (_, movieState) {
                if (movieState is MovieLoaded) {
                  List<Movie> movies = movieState.upComingMovies;

                  return Container(
                    height: 120,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movies.length,
                        itemBuilder: (context, i) => Container(
                              width: 90,
                              height: 120,
                              margin: EdgeInsets.only(
                                  left: (i == 0) ? defaultMargin : 0,
                                  right: (i == movies.length - 1)
                                      ? defaultMargin
                                      : 16),
                              child: ComingSoonCard(movies[i]),
                            )),
                  );
                } else {
                  return Container(
                    height: 120,
                    child: SpinKitChasingDots(
                      color: mainColor,
                      size: 50,
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 40)
          ],
        ),
      ),
    );
  }
}
