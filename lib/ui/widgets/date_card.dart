part of 'widgets.dart';

class DateCard extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final Function onTap;

  DateCard({this.date, this.isSelected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        width: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: (isSelected) ? mainColor : Colors.transparent),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              date.day.toString(),
              style: themeFont.copyWith(
                  color: (isSelected) ? Colors.black : Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            Text(
              date.shortDayName,
              style: themeFont.copyWith(
                  color: (isSelected) ? Colors.black : Colors.grey,
                  fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
