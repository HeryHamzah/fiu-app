part of 'pages.dart';

class MyWalletPage extends StatelessWidget {
  final PageEvent pageEvent;

  MyWalletPage(this.pageEvent);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(pageEvent);
        return;
      },
      child: Scaffold(
        backgroundColor: backColor,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: ListView(
                  children: [
                    BlocBuilder<UserBloc, UserState>(
                      builder: (_, userState) {
                        User user = (userState as UserLoaded).user;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Stack(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        context.bloc<PageBloc>().add(pageEvent);
                                      },
                                      child: Icon(Icons.arrow_back_ios,
                                          color: Colors.white)),
                                  Center(
                                      child: Text("My Wallet",
                                          style:
                                              themeFont.copyWith(fontSize: 18)))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 185,
                              width: double.infinity,
                              padding: EdgeInsets.all(20),
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 5.0,
                                        spreadRadius: 2.0,
                                        offset: Offset(3.0, 3.0),
                                        color: Colors.black.withOpacity(.5))
                                  ],
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        user.id.substring(0, 12).toUpperCase(),
                                        style: themeFont,
                                      ),
                                      Container(
                                        width: 50,
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    color: mainColor,
                                                    shape: BoxShape.circle),
                                              ),
                                            ),
                                            Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  color: Colors.red
                                                      .withOpacity(0.8),
                                                  shape: BoxShape.circle),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Balance",
                                            style: themeFont.copyWith(
                                                color: Colors.grey,
                                                fontSize: 16),
                                          ),
                                          Text(
                                              NumberFormat.currency(
                                                      locale: 'id_ID',
                                                      decimalDigits: 0,
                                                      symbol: 'IDR ')
                                                  .format(user.balance),
                                              style: themeFont.copyWith(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600))
                                        ],
                                      ),
                                      Image.asset(
                                        "assets/logo.png",
                                        width: 30,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Text("Recent Transactions",
                                style: themeFont.copyWith(fontSize: 16)),
                            SizedBox(
                              height: 10,
                            ),
                            FutureBuilder(
                                future:
                                    TransactionServices.getTransaction(user.id),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<FiuTransaction> transactions =
                                        snapshot.data;
                                    return generateTransactionList(
                                        transactions);
                                  } else {
                                    return SpinKitChasingDots(
                                        size: 50, color: mainColor);
                                  }
                                }),
                            SizedBox(
                              height: 80,
                            )
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 250,
                  height: 46,
                  margin: EdgeInsets.only(bottom: 20),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: mainColor,
                    child:
                        Text("Top Up", style: themeFont.copyWith(fontSize: 16)),
                    onPressed: () {
                      context
                          .bloc<PageBloc>()
                          .add(GoToTopUpPage(GoToMyWalletPage(pageEvent)));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column generateTransactionList(List<FiuTransaction> transactions) {
    transactions.sort((b, a) => a.time.compareTo(b.time));

    return Column(
        children: transactions.map((e) => TransactionCard(e)).toList());
  }
}
