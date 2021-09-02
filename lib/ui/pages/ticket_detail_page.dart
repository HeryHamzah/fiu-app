part of 'pages.dart';

class TicketDetailPage extends StatelessWidget {
  final Ticket ticket;
  final int tabIndex;

  TicketDetailPage(this.ticket, this.tabIndex);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          context
              .bloc<PageBloc>()
              .add(GoToMainPage(index: 1, tabIndex: tabIndex));
          return;
        },
        child: Scaffold(
          backgroundColor: backColor,
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 10),
                      child: Stack(
                        children: [
                          InkWell(
                              onTap: () {
                                context.bloc<PageBloc>().add(
                                    GoToMainPage(index: 1, tabIndex: tabIndex));
                              },
                              child: Icon(Icons.arrow_back_ios,
                                  color: Colors.white)),
                          Center(
                            child: Text("Ticket Details",
                                style: themeFont.copyWith(fontSize: 20)),
                          )
                        ],
                      ),
                    ),
                    TicketView(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 24, horizontal: 0),
                      drawArc: true,
                      triangleAxis: Axis.vertical,
                      borderRadius: 6,
                      drawDivider: true,
                      drawTriangle: false,
                      trianglePos: .77,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 200,
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(imageBaseURL +
                                        "w500" +
                                        ticket.movieDetail.backdropPath),
                                    fit: BoxFit.cover)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultMargin),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width -
                                    4 * defaultMargin,
                                child: Text(
                                  ticket.movieDetail.title,
                                  style: themeFont.copyWith(
                                      color: Colors.black, fontSize: 18),
                                  maxLines: 2,
                                  overflow: TextOverflow.clip,
                                )),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width -
                                4 * defaultMargin,
                            margin: EdgeInsets.symmetric(
                                horizontal: defaultMargin, vertical: 6),
                            child: Text(
                              ticket.movieDetail.yearDurationGenres,
                              style: themeFont.copyWith(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultMargin),
                            child: RatingStars(
                              voteAverage: ticket.movieDetail.voteAverage,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultMargin),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Cinema",
                                  style: themeFont.copyWith(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    ticket.theater.name,
                                    style: themeFont.copyWith(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.end,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultMargin),
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
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(ticket.dateTime.dateAndTime,
                                      textAlign: TextAlign.end,
                                      style: themeFont.copyWith(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 9),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultMargin),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Seat Numbers",
                                  style: themeFont.copyWith(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(ticket.seatsInString,
                                      style: themeFont.copyWith(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.end),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultMargin),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order ID",
                                  style: themeFont.copyWith(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(ticket.orderId,
                                      style: themeFont.copyWith(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.end),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: defaultMargin,
                          ),
                          // Divider(),
                          // generateDashedDivider(
                          //     MediaQuery.of(context).size.width -
                          //         2 * defaultMargin),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultMargin,
                                vertical: defaultMargin),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name:",
                                      style: themeFont.copyWith(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      ticket.username,
                                      style: themeFont.copyWith(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                    SizedBox(height: 9),
                                    Text(
                                      "Paid:",
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
                                          .format(ticket.totalPrice),
                                      style: themeFont.copyWith(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ],
                                ),
                                QrImage(
                                  version: 5,
                                  foregroundColor: Colors.black,
                                  errorCorrectionLevel: QrErrorCorrectLevel.M,
                                  padding: EdgeInsets.all(0),
                                  size: 100,
                                  data: ticket.orderId,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
