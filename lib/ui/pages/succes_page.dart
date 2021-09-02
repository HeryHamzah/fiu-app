part of 'pages.dart';

class SuccesReservationPage extends StatelessWidget {
  final Ticket ticket;
  final FiuTransaction transaction;

  SuccesReservationPage({this.ticket, this.transaction});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: FutureBuilder(
          future: proccesingTransaction(context),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      margin: EdgeInsets.only(bottom: 70),
                      child: SvgPicture.asset(
                        "assets/watching.svg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      "Happy Watching!",
                      style: themeFont.copyWith(fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "You have bought \nthe ticket successfully",
                      textAlign: TextAlign.center,
                      style: themeFont.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(height: 70),
                    Container(
                      width: 250,
                      height: 46,
                      margin: EdgeInsets.only(bottom: 20),
                      child: MaterialButton(
                          color: mainColor,
                          child: Text("My Ticket",
                              style: themeFont.copyWith(fontSize: 16)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          onPressed: () {
                            context
                                .bloc<PageBloc>()
                                .add(GoToMainPage(index: 1));
                          }),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        "Discover new movie? ",
                        style: themeFont,
                      ),
                      InkWell(
                        onTap: () {
                          context.bloc<PageBloc>().add(GoToMainPage());
                        },
                        child: Text("Back to Home",
                            style: themeFont.copyWith(color: mainColor)),
                      )
                    ])
                  ],
                ),
              );
            } else {
              return Center(
                child: SpinKitChasingDots(
                  color: mainColor,
                  size: 50,
                ),
              );
            }
          }),
    );
  }

  Future<void> proccesingTransaction(BuildContext context) async {
    context.bloc<UserBloc>().add(Purchase(ticket.totalPrice));
    context.bloc<TicketBloc>().add(BuyTicket(transaction.userID, ticket));

    await TransactionServices.saveTransaction(transaction);
  }
}

class SuccesTopUpPage extends StatelessWidget {
  final FiuTransaction transaction;

  SuccesTopUpPage(this.transaction);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: FutureBuilder(
          future: proccesingTopUp(context),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      margin: EdgeInsets.only(bottom: 70),
                      child: SvgPicture.asset(
                        "assets/wallet.svg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      "Yeeeyyy!",
                      style: themeFont.copyWith(fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "You have top up \nthe wallet successfully",
                      textAlign: TextAlign.center,
                      style: themeFont.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(height: 70),
                    Container(
                      width: 250,
                      height: 46,
                      margin: EdgeInsets.only(bottom: 20),
                      child: MaterialButton(
                          color: secondColor,
                          child: Text("My Wallet",
                              style: themeFont.copyWith(fontSize: 16)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          onPressed: () {
                            context
                                .bloc<PageBloc>()
                                .add(GoToMyWalletPage(GoToMainPage()));
                          }),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        "Discover new movie? ",
                        style: themeFont,
                      ),
                      InkWell(
                        onTap: () {
                          context.bloc<PageBloc>().add(GoToMainPage());
                        },
                        child: Text("Back to Home",
                            style: themeFont.copyWith(color: secondColor)),
                      )
                    ])
                  ],
                ),
              );
            } else {
              return Center(
                child: SpinKitChasingDots(
                  color: secondColor,
                  size: 50,
                ),
              );
            }
          }),
    );
  }

  Future<void> proccesingTopUp(BuildContext context) async {
    context.bloc<UserBloc>().add(TopUp(transaction.amount));

    await TransactionServices.saveTransaction(transaction);
  }
}
