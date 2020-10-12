part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final RegistrationData registrationData;

  SignUpPage(this.registrationData);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameController.text = widget.registrationData.name;
    emailController.text = widget.registrationData.email;
  }

  @override
  Widget build(BuildContext context) {
    // Change TextField color to accentColor1 (dark purple)
    context.bloc<ThemeBloc>().add(
          ChangeTheme(
            ThemeData().copyWith(primaryColor: accentColor1),
          ),
        );

    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSplashPage());

        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 20,
                      bottom: 22,
                    ),
                    height: 56,
                    child: Stack(
                      children: [
                        // Back button to Splash Page
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              // Load Splash Page
                              context.bloc<PageBloc>().add(GoToSplashPage());
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Create New\nAccount",
                            style: blackTextFont.copyWith(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Width 90 (diameter of "profile picture" 90)
                  // Height 90 (diameter of "profile picture" 90) + 14 (from diameter of "add picture icon": 28 / 2 = 14 (r = 14))
                  Container(
                    width: 90,
                    height: 104,
                    child: Stack(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // Check if profileImage is null then display default picture
                            image: DecorationImage(
                                image: (widget.registrationData.profileImage ==
                                        null)
                                    ? AssetImage("assets/user_pic.png")
                                    : FileImage(
                                        widget.registrationData.profileImage),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          // Wrap with GestureDetector to enable icon click
                          child: GestureDetector(
                            onTap: () async {
                              // If profile image is NULL then get picture
                              // If profile image is NOT NULL then set profileImage data to null alias DELETE image data
                              if (widget.registrationData.profileImage ==
                                  null) {
                                // Get picture (access gallery)
                                // Save picture path
                                widget.registrationData.profileImage =
                                    await getImage();
                              } else {
                                // Set picture data to NULL
                                widget.registrationData.profileImage = null;
                              }

                              // Change new state (Image changed)
                              setState(() {});
                            },
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // Check if profileImage is null then display add photo icon
                                image: DecorationImage(
                                  image: AssetImage(
                                    (widget.registrationData.profileImage ==
                                            null)
                                        ? "assets/btn_add_photo.png"
                                        : "assets/btn_del_photo.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Full Name",
                      hintText: "Full Name",
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
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
                    height: 16,
                  ),
                  TextField(
                    controller: confirmPasswordController,
                    // ObscureText -> hide text as Password
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Confirm Password",
                      hintText: "Confirm Password",
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FloatingActionButton(
                    backgroundColor: mainColor,
                    elevation: 0,
                    child: Icon(Icons.arrow_forward),
                    onPressed: () {
                      // Validation of textfield.
                      // If all textfield still empty
                      if (!(nameController.text.trim() != "" &&
                          emailController.text.trim() != "" &&
                          passwordController.text.trim() != "" &&
                          confirmPasswordController.text.trim() != "")) {
                        // Displaying Flushbar in TOP with message (fill all field first)
                        Flushbar(
                          duration: Duration(milliseconds: 1500),
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: Color(0xFFFF5C83),
                          message: "Please fill all the fields",
                        )..show(context);
                        // If email addess is NOT valid
                      } else if (!EmailValidator.validate(
                          emailController.text)) {
                        // Displaying Flushbar in TOP with message (Wrong formatted email address)
                        Flushbar(
                          duration: Duration(milliseconds: 1500),
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: Color(0xFFFF5C83),
                          message: "Wrong formatted email address",
                        )..show(context);
                        // If confirmation password is NOT same with password
                      } else if (passwordController.text !=
                          confirmPasswordController.text) {
                        // Displaying Flushbar in TOP with message (Mismatch password and confirmed password)
                        Flushbar(
                          duration: Duration(milliseconds: 1500),
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: Color(0xFFFF5C83),
                          message: "Mismatch password and confirmed password",
                        )..show(context);
                        // If password length less than 6 character
                      } else if (passwordController.text.length < 6) {
                        // Displaying Flushbar in TOP with message (Password length min 6 characters)
                        Flushbar(
                          duration: Duration(milliseconds: 1500),
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: Color(0xFFFF5C83),
                          message: "Password length min 6 characters",
                        )..show(context);
                        // If ALL TEXTFIELDS are Validated then save data
                      } else {
                        // Save data (name, email, password)
                        widget.registrationData.name = nameController.text;
                        widget.registrationData.email = emailController.text;
                        widget.registrationData.password =
                            passwordController.text;
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
