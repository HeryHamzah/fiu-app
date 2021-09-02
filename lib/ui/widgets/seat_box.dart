part of 'widgets.dart';

class SeatBox extends StatelessWidget {
  final String numberSeat;
  final bool isSelected;
  final bool isEnabled;
  final Function onTap;

  SeatBox(
      {this.numberSeat, this.isSelected = false, this.isEnabled, this.onTap});
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
          width: 35,
          height: 35,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: (isSelected) ? Color(0XFFFBD460) : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  width: 2,
                  color: (!isEnabled) ? Colors.grey : Color(0XFFFBD460))),
          child: Center(
            child: Text(
              (isEnabled) ? numberSeat : "X",
              style: themeFont.copyWith(
                  color: (!isEnabled)
                      ? Colors.grey
                      : (isSelected)
                          ? backColor
                          : Colors.white),
            ),
          )),
    );
  }
}
