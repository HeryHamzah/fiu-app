part of 'pages.dart';

class CheckOutPage extends StatelessWidget {
  final Ticket ticket;

  CheckOutPage(this.ticket);
  @override
  Widget build(BuildContext context) {
    int totalPrice = ticket.totalPrice + 500 * ticket.seats.length;

    return WillPopScope(
        onWillPop: () async {
          context.bloc<PageBloc>().add(GoToBookingPage(ticket.movieDetail));
          return;
        },
        child: Scaffold(
            backgroundColor: backColor,
            body: ListView(
              children: [
                BlocBuilder<UserBloc, UserState>(
                  builder: (_, userState) {
                    return Column(
                      children: [
                        ////note: APP BAR
                        Container(
                          margin: EdgeInsets.only(
                              left: defaultMargin, top: 20, bottom: 40),
                          child: Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  context
                                      .bloc<PageBloc>()
                                      .add(GoToBookingPage(ticket.movieDetail));
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                              Center(
                                child: Text(
                                  "Checkout Movie",
                                  style: themeFont.copyWith(fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        ),

                        //note: CONTENT
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              defaultMargin, 0, defaultMargin, 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 70,
                                height: 90,
                                margin: EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: NetworkImage(imageBaseURL +
                                            "w500" +
                                            ticket.movieDetail.posterPath),
                                        fit: BoxFit.cover)),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width -
                                        2 * defaultMargin -
                                        70 -
                                        20,
                                    child: Text(
                                      ticket.movieDetail.title,
                                      style: themeFont.copyWith(fontSize: 18),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width -
                                        2 * defaultMargin -
                                        70 -
                                        20,
                                    child: Text(
                                      ticket.movieDetail.yearDurationGenres,
                                      style: themeFont.copyWith(
                                          color: Colors.grey, fontSize: 12),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  RatingStars(
                                    voteAverage: ticket.movieDetail.voteAverage,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 2,
                          indent: defaultMargin,
                          endIndent: defaultMargin,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: defaultMargin),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order ID",
                                style: themeFont.copyWith(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                ticket.orderId,
                                style: themeFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: defaultMargin),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Cinema",
                                style: themeFont.copyWith(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  ticket.theater.name,
                                  maxLines: 2,
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                  style: themeFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: defaultMargin),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Date & Time",
                                style: themeFont.copyWith(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                ticket.dateTime.dateAndTime,
                                style: themeFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: defaultMargin),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Seat Number",
                                style: themeFont.copyWith(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  ticket.seatsInString,
                                  maxLines: 2,
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                  style: themeFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: defaultMargin),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Price",
                                style: themeFont.copyWith(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "${NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: "IDR ").format(ticket.theater.price)} x ${ticket.seats.length}",
                                style: themeFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: defaultMargin),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Fee",
                                style: themeFont.copyWith(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                NumberFormat.currency(
                                            locale: "id_ID",
                                            decimalDigits: 0,
                                            symbol: "IDR ")
                                        .format(500) +
                                    " x ${ticket.seats.length}",
                                style: themeFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: defaultMargin),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: themeFont.copyWith(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                NumberFormat.currency(
                                        locale: "id_ID",
                                        decimalDigits: 0,
                                        symbol: "IDR ")
                                    .format(totalPrice),
                                style: themeFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Divider(
                          color: Colors.grey,
                          height: 2,
                          indent: defaultMargin,
                          endIndent: defaultMargin,
                        ),
                        SizedBox(height: 20),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: defaultMargin),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Your Wallet",
                                style: themeFont.copyWith(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  NumberFormat.currency(
                                          locale: "id_ID",
                                          decimalDigits: 0,
                                          symbol: "IDR ")
                                      .format((userState as UserLoaded)
                                          .user
                                          .balance),
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                  style: themeFont.copyWith(
                                      color: ((userState as UserLoaded)
                                                  .user
                                                  .balance >=
                                              totalPrice)
                                          ? mainColor
                                          : secondColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          width: 250,
                          height: 46,
                          child: MaterialButton(
                              color: ((userState as UserLoaded).user.balance >=
                                      totalPrice)
                                  ? mainColor
                                  : secondColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                ((userState as UserLoaded).user.balance >
                                        totalPrice)
                                    ? "Checkout Now"
                                    : "Top Up My Wallet",
                                style: themeFont.copyWith(fontSize: 16),
                              ),
                              onPressed: ((userState as UserLoaded)
                                          .user
                                          .balance >=
                                      totalPrice)
                                  ? () async {
                                      FiuTransaction transaction =
                                          FiuTransaction(
                                              userID: (userState as UserLoaded)
                                                  .user
                                                  .id,
                                              picturePath:
                                                  ticket.movieDetail.posterPath,
                                              title: ticket.movieDetail.title,
                                              desc: ticket.theater.name,
                                              amount: -totalPrice,
                                              time: DateTime.now());

                                      context.bloc<PageBloc>().add(
                                          GoToSuccesReservationPage(
                                              ticket: ticket.copyWith(
                                                  totalPrice: totalPrice,
                                                  username:
                                                      (userState as UserLoaded)
                                                          .user
                                                          .name),
                                              transaction: transaction));
                                    }
                                  : () {
                                      context
                                          .bloc<PageBloc>()
                                          .add(GoToTopUpPage(GoToMainPage()));
                                    }),
                        )
                      ],
                    );
                  },
                )
              ],
            )));
  }
}
