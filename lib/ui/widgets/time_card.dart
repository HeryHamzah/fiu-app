part of 'widgets.dart';

class TimeCard extends StatelessWidget {
  final int time;
  final bool isSelected;
  final bool isEnabled;
  final Function onTap;

  TimeCard(
      {this.time, this.isSelected = false, this.isEnabled = true, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isEnabled) {
          if (onTap != null) {
            onTap();
          }
        }
      },
      child: Container(
        width: 90,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.transparent,
            border: Border.all(
                color: (!isEnabled)
                    ? Colors.grey
                    : (isSelected)
                        ? mainColor
                        : Colors.white)),
        child: Center(
          child: Text(
            "${time.toString()}:00",
            style: themeFont.copyWith(
                color: (!isEnabled)
                    ? Colors.grey
                    : (isSelected)
                        ? mainColor
                        : Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
