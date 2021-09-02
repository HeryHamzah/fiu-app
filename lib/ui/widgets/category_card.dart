part of 'widgets.dart';

class CategoryCard extends StatelessWidget {
  final String category;

  CategoryCard(this.category);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: (MediaQuery.of(context).size.width - 2 * defaultMargin - 16) / 2,
      decoration: BoxDecoration(
          color: (category == "Action")
              ? secondColor
              : (category == "Animation")
                  ? Colors.blue
                  : (category == "Crime")
                      ? Colors.orange[300]
                      : (category == "Horror")
                          ? Colors.teal[300]
                          : (category == "Romance")
                              ? Colors.pink[400]
                              : Colors.green,
          borderRadius: BorderRadius.circular(6)),
      child: Center(
        child: Text(
          category,
          style: themeFont.copyWith(fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
