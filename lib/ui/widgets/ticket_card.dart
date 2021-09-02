part of 'widgets.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;
  final Function onTap;

  TicketCard({this.ticket, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        height: 90,
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
                            fit: BoxFit.cover))),
                Container(
                    width: 70,
                    height: 90,
                    margin: EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: NetworkImage(imageBaseURL +
                                "w342" +
                                ticket.movieDetail.posterPath),
                            fit: BoxFit.cover))),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width -
                  2 * defaultMargin -
                  70 -
                  16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticket.movieDetail.title,
                    maxLines: 2,
                    style: themeFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(ticket.dateTime.dayAndDate,
                      style:
                          themeFont.copyWith(color: Colors.grey, fontSize: 14)),
                  SizedBox(
                    height: 2,
                  ),
                  Text(ticket.theater.name,
                      style:
                          themeFont.copyWith(color: Colors.grey, fontSize: 14))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
