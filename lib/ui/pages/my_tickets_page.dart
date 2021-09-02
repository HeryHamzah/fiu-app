part of 'pages.dart';

class MyTicketsPage extends StatelessWidget {
  final int tabIndex;
  MyTicketsPage(this.tabIndex);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: tabIndex,
      length: 2,
      child: Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("My Tickets", style: themeFont.copyWith(fontSize: 20)),
          bottom: TabBar(
            indicatorColor: mainColor,
            tabs: [
              Tab(
                child: Text(
                  "Newest",
                  style: themeFont.copyWith(fontSize: 16),
                ),
              ),
              Tab(
                  child:
                      Text("Oldest", style: themeFont.copyWith(fontSize: 16)))
            ],
          ),
        ),
        body: BlocBuilder<TicketBloc, TicketState>(
          builder: (_, ticketState) {
            List<Ticket> newestTickets = ticketState.tickets
                .where((ticket) => ticket.dateTime.isAfter(DateTime.now()))
                .toList();
            newestTickets.sort((a, b) => a.dateTime.compareTo(b.dateTime));
            List<Ticket> oldestTickets = ticketState.tickets
                .where((ticket) => !ticket.dateTime.isAfter(DateTime.now()))
                .toList();
            oldestTickets.sort((a, b) => a.dateTime.compareTo(b.dateTime));

            return TabBarView(children: [
              ListView(
                children: newestTickets
                    .map((e) => Container(
                          margin: EdgeInsets.only(
                              top: (e == newestTickets.first) ? 20 : 0,
                              left: defaultMargin,
                              right: defaultMargin,
                              bottom: 20),
                          child: TicketCard(
                            ticket: e,
                            onTap: () {
                              context
                                  .bloc<PageBloc>()
                                  .add(GoToTicketDetailPage(e, tabIndex: 0));
                            },
                          ),
                        ))
                    .toList(),
              ),
              ListView(
                children: oldestTickets
                    .map((e) => Container(
                          margin: EdgeInsets.only(
                              top: (e == oldestTickets.first) ? 20 : 0,
                              left: defaultMargin,
                              right: defaultMargin,
                              bottom: 20),
                          child: TicketCard(
                            ticket: e,
                            onTap: () {
                              context
                                  .bloc<PageBloc>()
                                  .add(GoToTicketDetailPage(e, tabIndex: 1));
                            },
                          ),
                        ))
                    .toList(),
              ),
            ]);
          },
        ),
      ),
    );
  }
}
