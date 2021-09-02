part of 'widgets.dart';

class TransactionCard extends StatelessWidget {
  final FiuTransaction transaction;

  TransactionCard(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 70,
                height: 90,
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: AssetImage("assets/cache_image.png"),
                        fit: BoxFit.cover)),
              ),
              Container(
                width: 70,
                height: 90,
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: (transaction.picturePath == null)
                            ? AssetImage("assets/topup_cover.png")
                            : NetworkImage(imageBaseURL +
                                "w342" +
                                transaction.picturePath),
                        fit: BoxFit.cover)),
              ),
            ],
          ),
          SizedBox(
            width:
                MediaQuery.of(context).size.width - 2 * defaultMargin - 70 - 16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  maxLines: 2,
                  style: themeFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  NumberFormat.currency(
                          locale: 'id_ID', decimalDigits: 0, symbol: "")
                      .format(transaction.amount),
                  style: themeFont.copyWith(
                      fontSize: 14,
                      color:
                          (transaction.amount > 0) ? mainColor : secondColor),
                ),
                Text(
                  transaction.desc,
                  style: themeFont.copyWith(fontSize: 14, color: Colors.grey),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
