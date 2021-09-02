part of 'widgets.dart';

class TheaterBox extends StatelessWidget {
  final Theater theater;
  final bool isSelected;
  final Function onTap;

  TheaterBox({this.theater, this.isSelected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      onDoubleTap: () {
        onTap();
        Navigator.pop(context);
      },
      child: Container(
        width: 250,
        height: 80,
        decoration: BoxDecoration(
            border: Border.all(
                color: (isSelected) ? Colors.transparent : Colors.grey),
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: (isSelected)
                    ? [Colors.pink[100], Colors.pink[200]]
                    : [Colors.transparent, Colors.transparent])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              theater.name,
              style: themeFont.copyWith(
                  color: (isSelected) ? backColor : Colors.white),
            ),
            Text(
              NumberFormat.currency(
                      locale: 'id_ID', decimalDigits: 0, symbol: "IDR ")
                  .format(theater.price),
              style: themeFont.copyWith(
                  color: (isSelected) ? backColor : Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
