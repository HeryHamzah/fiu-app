part of 'ticket_bloc.dart';

abstract class TicketEvent extends Equatable {
  const TicketEvent();
}

class BuyTicket extends TicketEvent {
  final Ticket ticket;
  final String userID;

  BuyTicket(this.userID, this.ticket);

  @override
  List<Object> get props => [userID, ticket];
}

class GetTickets extends TicketEvent {
  final String userID;

  GetTickets(this.userID);

  @override
  List<Object> get props => [userID];
}
