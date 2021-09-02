part of 'models.dart';

class Ticket extends Equatable {
  final String orderId;
  final String username;
  final MovieDetail movieDetail;
  final List<String> seats;
  final int totalPrice;
  final Theater theater;
  final DateTime dateTime;

  Ticket(
      {this.orderId,
      this.username,
      this.movieDetail,
      this.seats,
      this.totalPrice,
      this.theater,
      this.dateTime});

  Ticket copyWith(
          {String orderId,
          String username,
          MovieDetail movieDetail,
          List<String> seats,
          int totalPrice,
          Theater theater,
          DateTime dateTime}) =>
      Ticket(
          orderId: orderId ?? this.orderId,
          username: username ?? this.username,
          movieDetail: movieDetail ?? this.movieDetail,
          seats: seats ?? this.seats,
          totalPrice: totalPrice ?? this.totalPrice,
          theater: theater ?? this.theater,
          dateTime: dateTime ?? this.dateTime);

  String get seatsInString {
    String seatList = "";

    for (var seat in seats) {
      seatList += seat + (seat == seats.last ? "" : ", ");
    }
    return seatList;
  }

  @override
  List<Object> get props =>
      [orderId, username, movieDetail, seats, totalPrice, theater, dateTime];
}
