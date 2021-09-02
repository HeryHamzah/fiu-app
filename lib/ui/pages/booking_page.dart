part of 'pages.dart';

class BookingPage extends StatefulWidget {
  final MovieDetail movieDetail;

  BookingPage(this.movieDetail);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  List<DateTime> dates = [];
  DateTime selectedDate;
  Theater selectedTheater;
  List<int> time;
  int selectedTime;
  List<String> selectedSeats = [];
  int totalPrice;
  bool isValid = false;

  // void showTheaterModal() {
  //   showModalBottomSheet(
  //       backgroundColor: backColor,
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
  //       context: context,
  //       builder: (context) {
  //         return StatefulBuilder(
  //           builder: (BuildContext context, setModalState) {
  //             return Container(
  //               margin: EdgeInsets.all(20),
  //               child: ListView(
  //                 children: [
  //                   Text(
  //                     "Choose Theater",
  //                     style: themeFont.copyWith(fontSize: 18),
  //                   ),
  //                   Column(
  //                     children: dummyTheaters
  //                         .map((e) => Container(
  //                             margin: EdgeInsets.only(top: 15),
  //                             child: TheaterBox(
  //                                 theater: e,
  //                                 isSelected: e == selectedTheater,
  //                                 onTap: () {
  //                                   selectedTheater = e;
  //                                   setModalState(() {});
  //                                   setState(() {});
  //                                 })))
  //                         .toList(),
  //                   )
  //                 ],
  //               ),
  //             );
  //           },
  //         );
  //       });
  // }

  @override
  void initState() {
    super.initState();
    dates =
        List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
    time = List.generate(7, (index) => 10 + index * 2);
    selectedTheater = dummyTheaters[0];
    selectedDate = dates[0];
  }

  @override
  Widget build(BuildContext context) {
    totalPrice = selectedTheater.price * selectedSeats.length;

    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMovieDetailPage(
            movie: widget.movieDetail, pageEvent: GoToMainPage()));
        return;
      },
      child: Scaffold(
          backgroundColor: backColor,
          body: SafeArea(
            child: ListView(
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: 20, left: defaultMargin, bottom: 40),
                      child: Stack(
                        children: [
                          //note: ARROW BACK ICON
                          InkWell(
                            onTap: () {
                              context.bloc<PageBloc>().add(GoToMovieDetailPage(
                                  movie: widget.movieDetail,
                                  pageEvent: GoToMainPage()));
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),

                          //note: TITLE
                          Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                widget.movieDetail.title ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: themeFont.copyWith(fontSize: 16),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    //note: DATE
                    Container(
                      height: 100,
                      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: dates.length,
                          itemBuilder: (context, i) {
                            return DateCard(
                              date: dates[i],
                              isSelected: dates[i] == selectedDate,
                              onTap: () {
                                setState(() {
                                  selectedDate = dates[i];
                                });
                              },
                            );
                          }),
                    ),

                    //note: TIME
                    Container(
                        height: 40,
                        margin: EdgeInsets.only(top: 20, bottom: 30),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: time
                              .map((e) => Container(
                                    margin: EdgeInsets.only(
                                        left: (e == time.first)
                                            ? defaultMargin
                                            : 0,
                                        right: (e == time.last)
                                            ? defaultMargin
                                            : 16),
                                    child: TimeCard(
                                        time: e,
                                        isEnabled: e > DateTime.now().hour ||
                                            selectedDate.day !=
                                                DateTime.now().day,
                                        isSelected: e == selectedTime,
                                        onTap: () {
                                          if (e == selectedTime) {
                                            selectedTime = null;
                                          } else {
                                            selectedTime = e;
                                          }
                                          isValid = selectedTime != null &&
                                              selectedSeats.length > 0;
                                          setState(() {});
                                        }),
                                  ))
                              .toList(),
                        )),

                    //note: THEATER
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            backgroundColor: backColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30))),
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (BuildContext context, setModalState) {
                                  return Container(
                                    margin: EdgeInsets.all(20),
                                    child: ListView(
                                      children: [
                                        Text(
                                          "Choose Theater",
                                          style:
                                              themeFont.copyWith(fontSize: 18),
                                        ),
                                        Column(
                                          children: dummyTheaters
                                              .map((e) => Container(
                                                  margin:
                                                      EdgeInsets.only(top: 15),
                                                  child: TheaterBox(
                                                      theater: e,
                                                      isSelected:
                                                          e == selectedTheater,
                                                      onTap: () {
                                                        selectedTheater = e;
                                                        setModalState(() {});
                                                        setState(() {});
                                                      })))
                                              .toList(),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            });
                      },
                      child: Container(
                        height: 60,
                        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              MdiIcons.mapMarkerOutline,
                              size: 30,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width -
                                  2 * defaultMargin -
                                  30 -
                                  20 -
                                  2 * 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    selectedTheater.name,
                                    style: themeFont.copyWith(fontSize: 16),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    selectedTheater.location,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        themeFont.copyWith(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),

                    //note: SCREEN AND SEATS
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                          horizontal: defaultMargin, vertical: 25),
                      child: Image.asset(
                        "assets/screen.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    generateSeats(),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: defaultMargin),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          generateNoteSeat(
                              borderColor: Colors.grey,
                              fillColor: Colors.transparent,
                              text: "X",
                              note: "Closed"),
                          generateNoteSeat(
                              borderColor: Color(0XFFFBD460),
                              fillColor: Colors.transparent,
                              text: "",
                              note: "Available"),
                          generateNoteSeat(
                              borderColor: Colors.grey,
                              fillColor: Colors.grey,
                              text: "",
                              note: "Reserved"),
                          generateNoteSeat(
                              borderColor: Color(0XFFFBD460),
                              fillColor: Color(0XFFFBD460),
                              text: "",
                              note: "Selected")
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      width: 250,
                      height: 46,
                      margin: EdgeInsets.only(bottom: 50),
                      child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          color: mainColor,
                          disabledColor: Color(0XFFE4E4E4).withOpacity(.1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Buy ticket",
                                style: themeFont.copyWith(
                                    color:
                                        (isValid) ? Colors.white : Colors.grey,
                                    fontSize: 16),
                              ),
                              Text(
                                "|",
                                style: themeFont.copyWith(
                                  color: (isValid) ? Colors.white : Colors.grey,
                                ),
                              ),
                              Text(
                                NumberFormat.currency(
                                        locale: "id_ID",
                                        decimalDigits: 0,
                                        symbol: "IDR ")
                                    .format(totalPrice),
                                style: themeFont.copyWith(
                                  color: (isValid) ? Colors.white : Colors.grey,
                                ),
                              )
                            ],
                          ),
                          onPressed: (isValid)
                              ? () {
                                  context
                                      .bloc<PageBloc>()
                                      .add(GoToCheckOutPage(Ticket(
                                        orderId: randomAlphaNumeric(10)
                                            .toUpperCase(),
                                        movieDetail: widget.movieDetail,
                                        seats: selectedSeats,
                                        theater: selectedTheater,
                                        totalPrice: totalPrice,
                                        dateTime: DateTime(
                                            selectedDate.year,
                                            selectedDate.month,
                                            selectedDate.day,
                                            selectedTime),
                                      )));
                                }
                              : null),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }

  Column generateSeats() {
    List<int> rows = [6, 6, 6, 6, 6, 6];

    List<Row> seats = [];

    for (int i = 0; i < rows.length; i++) {
      seats.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              rows[i],
              (index) => Container(
                    margin: EdgeInsets.only(
                        right: (index + 1 == rows[i] / 2) ? 15 : 0),
                    child: SeatBox(
                        numberSeat:
                            "${String.fromCharCode(65 + i)}${(index + 1).toString()}",
                        onTap: () {
                          String numSeat =
                              "${String.fromCharCode(65 + i)}${(index + 1).toString()}";
                          if (selectedSeats.contains(numSeat)) {
                            selectedSeats.remove(numSeat);
                          } else {
                            selectedSeats.add(numSeat);
                          }
                          isValid =
                              selectedTime != null && selectedSeats.length > 0;
                          setState(() {});
                        },
                        isSelected: selectedSeats.contains(
                            "${String.fromCharCode(65 + i)}${(index + 1).toString()}"),
                        isEnabled: ((i + 1) % 2 == 1 && (index + 1) % 2 == 1) ||
                            ((i + 1) % 2 == 0 && (index + 1) % 2 == 0)),
                  ))));
    }

    return Column(
      children: seats,
    );
  }

  Row generateNoteSeat(
      {Color borderColor, Color fillColor, String text, String note}) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(3),
              color: fillColor),
          child: Center(
            child: Text(text,
                style: themeFont.copyWith(fontSize: 10, color: Colors.grey)),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          note,
          style: themeFont.copyWith(color: Colors.white70, fontSize: 12),
        )
      ],
    );
  }
}
