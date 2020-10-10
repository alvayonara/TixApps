part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSigninIn = false;

  @override
  Widget build(BuildContext context) {
    // Change TextField color
    context.bloc<ThemeBloc>().add(
          ChangeTheme(
            ThemeData().copyWith(primaryColor: accentColor2),
          ),
        );

    // Implement WillPopScope() in Scaffold()
    // When click Back -> to SplashPage
    return WillPopScope(
      onWillPop: () {
        // Load SplashPage
        context.bloc<PageBloc>().add(GoToSplashPage());

        // To implement onWillPop required return value
        // In this case we dont need any return so leave it like this one
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          // To prevent overflow when type email/password,
          // wrap it with ListView.
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 70,
                    child: Image.asset("assets/logo.png"),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 70,
                      bottom: 40,
                    ),
                    child: Text(
                      "Welcome Back,\nExplorer!",
                      style: blackTextFont.copyWith(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  TextField(
                    onChanged: (text) {
                      // setState -> To change display FloatingActionButton (enabled/disabled)
                      // If email valid false then FloatingActionButton set disabled
                      setState(() {
                        isEmailValid = EmailValidator.validate(text);
                      });
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Email Address",
                      hintText: "Email Address",
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    onChanged: (text) {
                      // setState -> To change display FloatingActionButton
                      // Constraint -> Password length at least 6
                      setState(() {
                        isPasswordValid = text.length >= 6;
                      });
                    },
                    controller: passwordController,
                    // ObscureText -> hide text as Password
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Password",
                      hintText: "Password",
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Text(
                        "Forgot Password? ",
                        style: greyTextFont.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "Get Now",
                        style: purpleTextFont,
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(
                        top: 40,
                        bottom: 30,
                      ),
                      // If SignIn true -> display SpinKitFadingCircle() (Loading Circular Progress Indicator)
                      // If SignIn false (login failed) -> display FloatingActionButton
                      child: isSigninIn
                          ? SpinKitFadingCircle(
                              color: mainColor,
                            )
                          : FloatingActionButton(
                              elevation: 0,
                              child: Icon(
                                Icons.arrow_forward,
                                color: isEmailValid && isPasswordValid
                                    ? Colors.white
                                    : Color(0xFFBEBEBE),
                              ),
                              backgroundColor: isEmailValid && isPasswordValid
                                  ? mainColor
                                  : Color(0xFFE4E4E4),
                              onPressed: isEmailValid && isPasswordValid
                                  ? () async {
                                      // set SignIn true when FloatingActionButton clicked
                                      setState(() {
                                        isSigninIn = true;
                                      });

                                      SignInSignUpResult result =
                                          await AuthServices.signIn(
                                              emailController.text,
                                              passwordController.text);

                                      // If login to Firebase return null (login failed)
                                      if (result.user == null) {
                                        // set SignIn false
                                        setState(() {
                                          isSigninIn = false;
                                        });

                                        // Displaying Flushbar in TOP with message (login failed)
                                        Flushbar(
                                          duration: Duration(seconds: 4),
                                          flushbarPosition:
                                              FlushbarPosition.TOP,
                                          backgroundColor: Color(0xFFFF5C83),
                                          message: result.message,
                                        )..show(context);
                                      }
                                    }
                                  : null,
                            ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Start fresh now? ",
                        style: greyTextFont.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "Sign Up",
                        style: purpleTextFont,
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
