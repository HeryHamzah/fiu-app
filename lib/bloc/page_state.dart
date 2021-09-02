part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();
}

class OnSplashPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnSignInPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnMainPage extends PageState {
  final int index;
  final int tabIndex;

  OnMainPage({this.index = 0, this.tabIndex = 0});
  @override
  List<Object> get props => [index, tabIndex];
}

class OnSignUpPage extends PageState {
  final RegistrationData registrationData;

  OnSignUpPage(this.registrationData);
  @override
  List<Object> get props => [registrationData];
}

class OnPreferencePage extends PageState {
  final RegistrationData registrationData;

  OnPreferencePage(this.registrationData);
  @override
  List<Object> get props => [registrationData];
}

class OnAccountConfirmationPage extends PageState {
  final RegistrationData registrationData;

  OnAccountConfirmationPage(this.registrationData);
  @override
  List<Object> get props => [registrationData];
}

class OnMovieDetailPage extends PageState {
  final Movie movie;
  final PageEvent pageEvent;

  OnMovieDetailPage({this.movie, this.pageEvent});

  @override
  List<Object> get props => [movie, pageEvent];
}

class OnBookingPage extends PageState {
  final MovieDetail movieDetail;

  OnBookingPage(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnCheckOutPage extends PageState {
  final Ticket ticket;

  OnCheckOutPage(this.ticket);

  @override
  List<Object> get props => [ticket];
}

class OnSuccesReservationPage extends PageState {
  final Ticket ticket;
  final FiuTransaction transaction;

  OnSuccesReservationPage({this.ticket, this.transaction});

  @override
  List<Object> get props => [ticket, transaction];
}

class OnTopUpPage extends PageState {
  final PageEvent pageEvent;

  OnTopUpPage(this.pageEvent);
  @override
  List<Object> get props => [pageEvent];
}

class OnSuccesTopUpPage extends PageState {
  final FiuTransaction transaction;

  OnSuccesTopUpPage(this.transaction);

  @override
  List<Object> get props => [transaction];
}

class OnProfilePage extends PageState {
  @override
  List<Object> get props => [];
}

class OnEditProfilePage extends PageState {
  final User user;

  OnEditProfilePage(this.user);
  @override
  List<Object> get props => [user];
}

class OnMyWalletPage extends PageState {
  final PageEvent pageEvent;

  OnMyWalletPage(this.pageEvent);
  @override
  List<Object> get props => [pageEvent];
}

class OnTicketDetailPage extends PageState {
  final Ticket ticket;
  final int tabIndex;

  OnTicketDetailPage(this.ticket, {this.tabIndex = 0});

  @override
  List<Object> get props => [ticket, tabIndex];
}

class OnResetPasswordPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnFavoriteMoviesPage extends PageState {
  @override
  List<Object> get props => [];
}
