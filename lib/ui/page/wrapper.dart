part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Wrapper will get FirebaseUser data
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);

    // prevPageEvent is used to prevent load page more than one (duplicate page).
    // Firebase auth sometime give same state -> load page more than one
    // solution: catat state sebelumnya agar tidak pindah ke page yang sama
    if (firebaseUser == null) {
      // If prevPageEvent IS NOT Splash Page then GoToSplashPage
      if (!(prevPageEvent is GoToSplashPage)) {
        prevPageEvent = GoToSplashPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    } else {
      // If prevPageEvent IS NOT Main Page then GoToMainPage
      if (!(prevPageEvent is GoToMainPage)) {
        prevPageEvent = GoToMainPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    }

    // Return type: PageState
    // If page state = OnSplashPage then -> load SplashPage()
    // else -> (If page state = OnLoginPage then -> load SignInPage()
    // else -> load MainPage())
    return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) => (pageState is OnSplashPage)
            ? SplashPage()
            : (pageState is OnLoginPage)
                ? SignInPage()
                : MainPage());
  }
}
