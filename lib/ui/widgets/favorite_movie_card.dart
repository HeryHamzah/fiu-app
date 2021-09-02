part of 'widgets.dart';

class FavoriteMovieCard extends StatelessWidget {
  final Movie movie;
  final Function onTap;

  FavoriteMovieCard(this.movie, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        // color: secondColor,
        child: Stack(
          children: [
            Column(
              children: [
                Flexible(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                image: AssetImage("assets/cache_image.png"),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                image: NetworkImage(
                                    imageBaseURL + "w780" + movie.posterPath ??
                                        movie.backdropPath),
                                fit: BoxFit.cover)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  movie.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: themeFont,
                ),
                SizedBox(
                  height: 4,
                ),
                RatingStars(
                  voteAverage: movie.voteAverage,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
