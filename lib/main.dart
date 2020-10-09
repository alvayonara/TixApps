import 'package:flutter/material.dart';
import 'package:tix_apps/service/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () async {
                  SignInSignUpResult result = await AuthServices.signUp(
                      "alfred@gmail.com",
                      "123456",
                      "Alva",
                      ["Horror", "Comedy"],
                      "Japan");

                  if (result.user == null) {
                    print(result.message);
                  } else {
                    print(result.user.toString());
                  }
                },
                child: Text("Sign Up"),
              ),
              RaisedButton(
                onPressed: () async {
                  SignInSignUpResult result = await AuthServices.signIn(
                    "alfred@gmail.com",
                    "21312321",
                  );

                  if (result.user == null) {
                    print(result.message);
                  } else {
                    print(result.user.toString());
                  }
                },
                child: Text("Sign In"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
