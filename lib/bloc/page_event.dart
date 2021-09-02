part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GoToSplashPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToSignInPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToSignUpPage extends PageEvent {
  final RegistrationData registrationData;

  GoToSignUpPage(this.registrationData);
  @override
  List<Object> get props => [registrationData];
}

class GoToMainPage extends PageEvent {
  final int index;
  final int tabIndex;

  GoToMainPage({this.index = 0, this.tabIndex = 0});
  @override
  List<Object> get props => [index, tabIndex];
}

class GoToPreferencePage extends PageEvent {
  final RegistrationData registrationData;

  GoToPreferencePage(this.registrationData);
  @override
  List<Object> get props => [registrationData];
}

class GoToAccountConfirmationPage extends PageEvent {
  final RegistrationData registrationData;

  GoToAccountConfirmationPage(this.registrationData);
  @override
  List<Object> get props => [registrationData];
}

class GoToMovieDetailPage extends PageEvent {
  final Movie movie;
  final PageEvent pageEvent;

  GoToMovieDetailPage({this.movie, this.pageEvent});

  @override
  List<Object> get props => [movie, pageEvent];
}

class GoToBookingPage extends PageEvent {
  final MovieDetail movieDetail;

  GoToBookingPage(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class GoToCheckOutPage extends PageEvent {
  final Ticket ticket;

  GoToCheckOutPage(this.ticket);

  @override
  List<Object> get props => [ticket];
}

class GoToSuccesReservationPage extends PageEvent {
  final Ticket ticket;
  final FiuTransaction transaction;

  GoToSuccesReservationPage({this.ticket, this.transaction});

  @override
  List<Object> get props => [ticket, transaction];
}

class GoToTopUpPage extends PageEvent {
  final PageEvent pageEvent;

  GoToTopUpPage(this.pageEvent);
  @override
  List<Object> get props => [pageEvent];
}

class GoToSuccesTopUpPage extends PageEvent {
  final FiuTransaction transaction;

  GoToSuccesTopUpPage(this.transaction);

  @override
  List<Object> get props => [transaction];
}

class GoToProfilePage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToEditProfilePage extends PageEvent {
  final User user;

  GoToEditProfilePage(this.user);
  @override
  List<Object> get props => [user];
}

class GoToMyWalletPage extends PageEvent {
  final PageEvent pageEvent;

  GoToMyWalletPage(this.pageEvent);
  @override
  List<Object> get props => [pageEvent];
}

class GoToTicketDetailPage extends PageEvent {
  final Ticket ticket;
  final int tabIndex;

  GoToTicketDetailPage(this.ticket, {this.tabIndex = 0});

  @override
  List<Object> get props => [ticket, tabIndex];
}

class GoToResetPasswordPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToFavoriteMoviesPage extends PageEvent {
  @override
  List<Object> get props => [];
}
