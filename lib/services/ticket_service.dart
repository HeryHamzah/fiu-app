part of 'services.dart';

class TicketServices {
  static CollectionReference _ticketCollection =
      FirebaseFirestore.instance.collection('tickets');

  static Future<void> saveTicket(Ticket ticket, String userID) async {
    await _ticketCollection.doc().set({
      'userID': userID,
      'orderID': ticket.orderId,
      'movieID': ticket.movieDetail.id,
      'cinema': ticket.theater.name,
      'seats': ticket.seats,
      'username': ticket.username,
      'dateTime': ticket.dateTime.millisecondsSinceEpoch,
      'totalPrice': ticket.totalPrice
    });
  }

  static Future<List<Ticket>> getTickets(String userID) async {
    QuerySnapshot snapshot = await _ticketCollection.get();
    var documents =
        snapshot.docs.where((document) => document.data()['userID'] == userID);

    List<Ticket> tickets = [];

    for (var document in documents) {
      MovieDetail movieDetail = await MovieServices.getDetailMovies(null,
          movieID: document.data()['movieID']);

      tickets.add(Ticket(
          orderId: document.data()['orderID'],
          username: document.data()['username'],
          movieDetail: movieDetail,
          seats: (document.data()['seats'] as List)
              .map((e) => e as String)
              .toList(),
          totalPrice: document.data()['totalPrice'],
          theater: Theater(name: document.data()['cinema']),
          dateTime: DateTime.fromMillisecondsSinceEpoch(
              document.data()['dateTime'])));
    }

    return tickets;
  }
}
