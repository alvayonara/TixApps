part of 'pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Splash Page"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Import flutter_bloc first in pages.dart
            // Button Event to load GoToLoginPage()
            context.bloc<PageBloc>().add(GoToLoginPage());
          },
          child: Text("Go Sign In Page"),
        ),
      ),
    );
  }
}
