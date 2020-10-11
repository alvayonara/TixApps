part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();

  @override
  List<Object> get props => [];
}

class OnInitialPage extends PageState {}

class OnSplashPage extends PageState {}

class OnRegistrationPage extends PageState {
  final RegistrationData registrationData;

  OnRegistrationPage(this.registrationData);
}

class OnPreferencesPage extends PageState {
  final RegistrationData registrationData;

  OnPreferencesPage(this.registrationData);
}

class OnAccountConfirmationPage extends PageState {
  final RegistrationData registrationData;

  OnAccountConfirmationPage(this.registrationData);
}

class OnLoginPage extends PageState {}

class OnMainPage extends PageState {}
