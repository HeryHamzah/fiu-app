part of 'pages.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;
  final PageEvent pageEvent;

  MovieDetailPage({this.movie, this.pageEvent});
  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  MovieDetail movieDetail;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(widget.pageEvent);
        return;
      },
      child: Scaffold(
        backgroundColor: backColor,
        body: Center(
          child: ListView(
            children: [
              FutureBuilder(
                  future: MovieServices.getDetailMovies(widget.movie),
                  builder: (_, snapshot) {
                    movieDetail = snapshot.data;

                    return Column(
                      children: [
                        //note: BACKDROP
                        Stack(children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 2,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(imageBaseURL +
                                        "w1280" +
                                        widget.movie.backdropPath),
                                    fit: BoxFit.cover)),
                            child: Container(
                                height: MediaQuery.of(context).size.height / 2,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment(0, 1),
                                        end: Alignment(0, 0.1),
                                        colors: [
                                      backColor,
                                      backColor.withOpacity(0)
                                    ]))),
                          ),

                          //note: BACK ICON
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.black.withOpacity(0.09)),
                                margin: EdgeInsets.only(
                                    top: 20, left: defaultMargin),
                                child: InkWell(
                                  onTap: () {
                                    context
                                        .bloc<PageBloc>()
                                        .add(widget.pageEvent);
                                  },
                                  child: Center(
                                    child: Icon(Icons.arrow_back_ios,
                                        color: Colors.white, size: 24),
                                  ),
                                ),
                              ),
                              BlocBuilder<UserBloc, UserState>(
                                builder: (_, userState) {
                                  if (userState is UserLoaded) {
                                    List<num> favoriteMovies =
                                        userState.user.favoriteMovies;

                                    return Container(
                                      margin: EdgeInsets.only(
                                          top: 20, right: defaultMargin),
                                      child: InkWell(
                                        onTap: () {
                                          if (favoriteMovies
                                              .contains(widget.movie.id)) {
                                            context.bloc<UserBloc>().add(
                                                RemoveFavorite(
                                                    widget.movie.id));
                                          } else {
                                            context.bloc<UserBloc>().add(
                                                AddFavorite(widget.movie.id));
                                          }
                                          setState(() {});
                                          Fluttertoast.showToast(
                                              msg: (favoriteMovies.contains(
                                                      widget.movie.id))
                                                  ? "Remove from Favorites"
                                                  : "Add to Favorites",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: backColor,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        },
                                        child: Icon(
                                          (favoriteMovies
                                                  .contains(widget.movie.id))
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          size: 24,
                                          color: mainColor,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return SpinKitChasingDots(
                                        color: mainColor, size: 24);
                                  }
                                },
                              ),
                            ],
                          ),

                          //note: TITLE
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width -
                                  2 * defaultMargin,
                              margin: EdgeInsets.symmetric(
                                  horizontal: defaultMargin),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(widget.movie.title,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: themeFont.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600)),
                                  (snapshot.hasData)
                                      ? Text(
                                          movieDetail.yearDurationGenres,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: themeFont.copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        )
                                      : Center(
                                          child: SpinKitChasingDots(
                                            size: 30,
                                            color: mainColor,
                                          ),
                                        ),
                                  RatingStars(
                                      voteAverage: widget.movie.voteAverage)
                                ],
                              ),
                            ),
                          )
                        ]),

                        //note: PLOT SUMMARY
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 20, left: defaultMargin, bottom: 10),
                            child: Text(
                              "Plot Summary",
                              style: themeFont.copyWith(fontSize: 16),
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                top: 10,
                                left: defaultMargin,
                                right: defaultMargin),
                            child: Text(
                              widget.movie.overview,
                              textAlign: TextAlign.justify,
                              style: themeFont.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w300),
                            )),

                        //note: CAST
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 20, left: defaultMargin, bottom: 10),
                            child: Text(
                              "Cast",
                              style: themeFont.copyWith(fontSize: 16),
                            ),
                          ),
                        ),
                        FutureBuilder(
                            future: MovieServices.getCredits(widget.movie.id),
                            builder: (_, snapshotCredits) {
                              List<Credits> credits = snapshotCredits.data;

                              return (snapshotCredits.hasData)
                                  ? Container(
                                      height: 150,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: credits.length,
                                          itemBuilder: (context, i) {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 70,
                                                  height: 70,
                                                  margin: EdgeInsets.only(
                                                      bottom: 5),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.white),
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: (credits[i]
                                                                      .profilePath ==
                                                                  null)
                                                              ? AssetImage(
                                                                  "assets/profile.png")
                                                              : NetworkImage(
                                                                  imageBaseURL +
                                                                      "w500" +
                                                                      credits[i]
                                                                          .profilePath),
                                                          fit: BoxFit.cover)),
                                                ),
                                                SizedBox(
                                                  width: 110,
                                                  child: Text(credits[i].name,
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: themeFont.copyWith(
                                                          fontSize: 12)),
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                SizedBox(
                                                  width: 110,
                                                  child: Text(
                                                      credits[i].character,
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: themeFont.copyWith(
                                                          color: Colors.grey,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w300)),
                                                ),
                                              ],
                                            );
                                          }),
                                    )
                                  : Container(
                                      height: 70,
                                      child: SpinKitChasingDots(
                                        color: mainColor,
                                      ),
                                    );
                            }),

                        Container(
                          width: 250,
                          height: 46,
                          margin: EdgeInsets.only(top: 15, bottom: 40),
                          child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text("Reservation",
                                  style: themeFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              color: mainColor,
                              onPressed: () {
                                context
                                    .bloc<PageBloc>()
                                    .add(GoToBookingPage(movieDetail));
                              }),
                        )
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
