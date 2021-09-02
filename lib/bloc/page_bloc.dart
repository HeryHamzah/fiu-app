import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fiu/model/models.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(OnSplashPage());

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if (event is GoToSplashPage) {
      yield OnSplashPage();
    } else if (event is GoToSignInPage) {
      yield OnSignInPage();
    } else if (event is GoToSignUpPage) {
      yield OnSignUpPage(event.registrationData);
    } else if (event is GoToMainPage) {
      yield OnMainPage(index: event.index, tabIndex: event.tabIndex);
    } else if (event is GoToPreferencePage) {
      yield OnPreferencePage(event.registrationData);
    } else if (event is GoToAccountConfirmationPage) {
      yield OnAccountConfirmationPage(event.registrationData);
    } else if (event is GoToMovieDetailPage) {
      yield OnMovieDetailPage(movie: event.movie, pageEvent: event.pageEvent);
    } else if (event is GoToBookingPage) {
      yield OnBookingPage(event.movieDetail);
    } else if (event is GoToCheckOutPage) {
      yield OnCheckOutPage(event.ticket);
    } else if (event is GoToTopUpPage) {
      yield OnTopUpPage(event.pageEvent);
    } else if (event is GoToSuccesReservationPage) {
      yield OnSuccesReservationPage(
          ticket: event.ticket, transaction: event.transaction);
    } else if (event is GoToSuccesTopUpPage) {
      yield OnSuccesTopUpPage(event.transaction);
    } else if (event is GoToProfilePage) {
      yield OnProfilePage();
    } else if (event is GoToEditProfilePage) {
      yield OnEditProfilePage(event.user);
    } else if (event is GoToMyWalletPage) {
      yield OnMyWalletPage(event.pageEvent);
    } else if (event is GoToTicketDetailPage) {
      yield OnTicketDetailPage(event.ticket, tabIndex: event.tabIndex);
    } else if (event is GoToResetPasswordPage) {
      yield OnResetPasswordPage();
    } else if (event is GoToFavoriteMoviesPage) {
      yield OnFavoriteMoviesPage();
    }
  }
}
