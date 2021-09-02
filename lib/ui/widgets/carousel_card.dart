part of 'widgets.dart';

class CarouselCard extends StatelessWidget {
  final Movie movie;

  CarouselCard(this.movie);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 5,
          child: Stack(
            children: [
              Container(
                width: 200,
                height: 250,
                margin: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/cache_image.png"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              (movie.posterPath == null)
                  ? Container()
                  : Container(
                      width: 200,
                      height: 250,
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                imageBaseURL + "w500" + movie.posterPath),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            width: 200,
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 160.0 / 3,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                      child: Text(
                    (movie.adult) ? "D 17+" : "SU",
                    style: themeFont.copyWith(
                        color: (movie.adult) ? secondColor : Colors.grey,
                        fontWeight: FontWeight.w600),
                  )),
                ),
                Container(
                  width: 160.0 / 3 + 20,
                  height: 35,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        MdiIcons.eye,
                        color: mainColor,
                        size: 18,
                      ),
                      SizedBox(
                        width: 1,
                      ),
                      Text(movie.popularity.toStringAsFixed(0),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: themeFont.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Container(
                  width: 160.0 / 3,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        MdiIcons.starCircle,
                        color: mainColor,
                        size: 18,
                      ),
                      SizedBox(
                        width: 1,
                      ),
                      Text(movie.voteAverage.toString(),
                          style:
                              themeFont.copyWith(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
