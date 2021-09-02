part of 'widgets.dart';

class TopUpCard extends StatelessWidget {
  final int amount;
  final double width;
  final bool isSelected;
  final Function onTap;

  TopUpCard(
      {this.amount, this.width = 90, this.isSelected = false, this.onTap});

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
        height: 60,
        decoration: BoxDecoration(
            color: (isSelected) ? Colors.pink[200] : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
                color: (isSelected) ? Colors.transparent : Colors.grey)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "IDR",
              style: themeFont.copyWith(
                  color: (isSelected) ? backColor : Colors.grey, fontSize: 16),
            ),
            Text(
                NumberFormat.currency(
                        locale: "id_ID", decimalDigits: 0, symbol: "")
                    .format(amount),
                style: themeFont.copyWith(
                    fontSize: 16,
                    color: (isSelected) ? backColor : Colors.white))
          ],
        ),
      ),
    );
  }
}
