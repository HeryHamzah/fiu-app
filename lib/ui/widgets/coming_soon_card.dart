part of 'widgets.dart';

class ComingSoonCard extends StatelessWidget {
  final Movie movie;

  ComingSoonCard(this.movie);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 90,
          height: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  image: AssetImage("assets/cache_image.png"),
                  fit: BoxFit.cover)),
        ),
        Container(
          width: 90,
          height: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  image: NetworkImage(
                      imageBaseURL + "w780" + movie.posterPath ??
                          movie.backdropPath),
                  fit: BoxFit.cover)),
        ),
      ],
    );
  }
}
