import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tix_apps/model/models.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  // Set initialState to OnInitialPage() state
  @override
  PageState get initialState => OnInitialPage();

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    // Event -> GoToSplashPage then load OnSplashPage() state
    // Event -> GoToLoginPage then load OnLoginPage() state
    // Event -> GoToMainPage then load OnMainPage() state
    // Event -> GoToRegistrationPage then load OnRegistrationPage() state
    // Event -> GoToPreferencesPage then load OnPreferencesPage() state
    // Event -> GoToAccountConfirmationPage then load OnAccountConfirmationPage() state
    if (event is GoToSplashPage) {
      yield OnSplashPage();
    } else if (event is GoToLoginPage) {
      yield OnLoginPage();
    } else if (event is GoToMainPage) {
      yield OnMainPage();
    } else if (event is GoToRegistrationPage) {
      yield OnRegistrationPage(event.registrationData);
    } else if (event is GoToPreferencesPage) {
      yield OnPreferencesPage(event.registrationData);
    } else if (event is GoToAccountConfirmationPage) {
      yield OnAccountConfirmationPage(event.registrationData);
    }
  }
}
