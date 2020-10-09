part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main page"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            AuthServices.signOut();
          },
          child: Text("Sign out"),
        ),
      ),
    );
  }
}
