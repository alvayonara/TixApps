part of 'services.dart';

class UserServices {
  static CollectionReference _userCollection =
      Firestore.instance.collection('users');

  static Future<void> updateUser(User user) async {
    // String genres = "";

    // // Algorithm to append list of genre into one sentence separated with comma
    // // Ex: result from API -> "Horror", "Romance", "Action"
    // //     after -> "Horror,Romance,Action"
    // for (var genre in user.selectedGenres) {
    //   // If Genre list in last, then not print comma but only null
    //   genres += genre + ((genre != user.selectedGenres.last) ? ',' : '');
    // }

    // When profilePicture is not set (default),
    // then set data to null in firestore
    _userCollection.document(user.id).setData({
      'email': user.email,
      'name': user.name,
      'balance': user.balance,
      'selectedGenres': user.selectedGenres,
      'selectedLanguage': user.selectedLanguage,
      'profilePicture': user.profilePicture ?? ""
    });
  }

  // This method is used to get user data by id when successfully login
  static Future<User> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.document(id).get();

    // Mapping it as User
    // in selectedGenres return as list of array
    return User(id, snapshot.data['email'],
        balance: snapshot.data['balance'],
        name: snapshot.data['name'],
        profilePicture: snapshot.data['profilePicture'],
        selectedGenres: (snapshot.data['selectedGenres'] as List)
            .map((e) => e.toString())
            .toList(),
        selectedLanguage: snapshot.data['selectedLanguage']);
  }
}
