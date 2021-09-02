part of 'widgets.dart';

class PreferenceCard extends StatelessWidget {
  final double width;
  final double height;
  final Function onTap;
  final String title;
  final bool isSelected;

  PreferenceCard(this.title,
      {this.width = 144,
      this.height = 60,
      this.onTap,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: (isSelected) ? secondColor : Colors.white,
              border: Border.all(
                  color: (isSelected) ? Colors.transparent : Colors.grey)),
          child: Center(
            child: Text(
              title,
              style: themeFont.copyWith(
                  color: (isSelected) ? Colors.white : backColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ));
  }
}
