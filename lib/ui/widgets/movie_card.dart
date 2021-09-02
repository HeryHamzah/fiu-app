part of 'widgets.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  MovieCard(this.movie);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: 210,
            height: 140,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: AssetImage("assets/cache_image2.png"),
                    fit: BoxFit.cover))),
        Container(
            width: 210,
            height: 140,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: NetworkImage(
                        imageBaseURL + "w780" + movie.backdropPath ??
                            movie.posterPath),
                    fit: BoxFit.cover)),
            child: Container(
              width: 210,
              height: 140,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.81),
                      Colors.black.withOpacity(0)
                    ]),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  movie.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: themeFont,
                ),
              ),
            )),
      ],
    );
  }
}
