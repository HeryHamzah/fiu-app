part of 'widgets.dart';

class RatingStars extends StatelessWidget {
  final double voteAverage;

  RatingStars({this.voteAverage});

  @override
  Widget build(BuildContext context) {
    int length = (voteAverage / 2).round();

    List<Widget> widgets = List.generate(
        5,
        (index) => Icon(
              (index < length) ? MaterialIcons.star : MaterialIcons.star_border,
              color: mainColor,
              size: 20,
            ));

    widgets.insert(
        0,
        Text(
          "$voteAverage ",
          style:
              themeFont.copyWith(color: mainColor, fontWeight: FontWeight.bold),
        ));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgets,
    );
  }
}
