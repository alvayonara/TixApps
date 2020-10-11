part of 'models.dart';

class RegistrationData {
  String name;
  String email;
  String password;
  List<String> selectedGenres;
  String selectedLanguages;
  File profileImage;

  // Make it optional
  // Step register
  RegistrationData({
    this.name = "",
    this.email = "",
    this.password = "",
    this.selectedGenres = const [],
    this.selectedLanguages = "",
    this.profileImage,
  });
}
