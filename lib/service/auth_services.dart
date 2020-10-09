part of 'services.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  // SignUp method
  // Return type as SignInSignUpResult class
  static Future<SignInSignUpResult> signUp(String email, String password,
      String name, List<String> selectedGenres, String selectedLanguage) async {
    // Using try-catch to handle error when register data
    try {
      // Return object if auth success
      // if auth fail then return null
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Set default balance value (50000)
      User user = result.user.convertToUser(
          name: name,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage);

      // Send user data to firestore
      // updateUser() is void method
      await UserServices.updateUser(user);

      // Return: assign to class SignInSignUpResult with parameter user
      return SignInSignUpResult(user: user);
    } catch (e) {
      // Return: assign to class SignInSignUpResult with parameter error message
      return SignInSignUpResult(message: e.toString().split(',')[1]);
    }
  }

  // SignIn method
  static Future<SignInSignUpResult> signIn(
      String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User user = await result.user.fromFirestore();

      return SignInSignUpResult(user: user);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split(',')[1]);
    }
  }

  // SignOut method
  static Future<void> signOut() async {
    await _auth.signOut();
  }

  // Notify if there is change in Firebase Authentication
  static Stream<FirebaseUser> get userStream => _auth.onAuthStateChanged;
}

class SignInSignUpResult {
  final User user;
  final String message;

  SignInSignUpResult({this.user, this.message});
}
