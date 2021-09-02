part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    auth.User firebaseUser = Provider.of<auth.User>(context);

    if (firebaseUser == null) {
      if (!(prevPageEvent is GoToSplashPage)) {
        prevPageEvent = GoToSplashPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    } else {
      if (!(prevPageEvent is GoToMainPage)) {
        context.bloc<UserBloc>().add(LoadUser(firebaseUser.uid));
        context.bloc<TicketBloc>().add(GetTickets(firebaseUser.uid));

        prevPageEvent = GoToMainPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    }

    return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) => (pageState is OnSplashPage)
            ? SplashPage()
            : (pageState is OnSignInPage)
                ? SignInPage()
                : (pageState is OnSignUpPage)
                    ? SignUpPage(pageState.registrationData)
                    : (pageState is OnPreferencePage)
                        ? PreferencePage(pageState.registrationData)
                        : (pageState is OnAccountConfirmationPage)
                            ? AccountConfirmationPage(
                                pageState.registrationData)
                            : (pageState is OnMovieDetailPage)
                                ? MovieDetailPage(
                                    movie: pageState.movie,
                                    pageEvent: pageState.pageEvent,
                                  )
                                : (pageState is OnBookingPage)
                                    ? BookingPage(pageState.movieDetail)
                                    : (pageState is OnCheckOutPage)
                                        ? CheckOutPage(pageState.ticket)
                                        : (pageState is OnTopUpPage)
                                            ? TopUpPage(pageState.pageEvent)
                                            : (pageState
                                                    is OnSuccesReservationPage)
                                                ? SuccesReservationPage(
                                                    ticket: pageState.ticket,
                                                    transaction:
                                                        pageState.transaction)
                                                : (pageState
                                                        is OnSuccesTopUpPage)
                                                    ? SuccesTopUpPage(
                                                        pageState.transaction)
                                                    : (pageState
                                                            is OnProfilePage)
                                                        ? ProfilePage()
                                                        : (pageState
                                                                is OnEditProfilePage)
                                                            ? EditProfilePage(
                                                                pageState.user)
                                                            : (pageState
                                                                    is OnMyWalletPage)
                                                                ? MyWalletPage(
                                                                    pageState
                                                                        .pageEvent)
                                                                : (pageState
                                                                        is OnTicketDetailPage)
                                                                    ? TicketDetailPage(
                                                                        pageState
                                                                            .ticket,
                                                                        pageState
                                                                            .tabIndex)
                                                                    : (pageState
                                                                            is OnResetPasswordPage)
                                                                        ? ResetPasswordPage()
                                                                        : (pageState
                                                                                is OnFavoriteMoviesPage)
                                                                            ? FavoriteMoviesPage()
                                                                            : MainPage(
                                                                                index: (pageState as OnMainPage).index,
                                                                                tabIndex: (pageState as OnMainPage).tabIndex,
                                                                              ));
  }
}
