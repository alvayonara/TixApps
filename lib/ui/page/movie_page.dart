part of 'pages.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Header layout. Consist of Profile image, Name, and Balance.
        Container(
          decoration: BoxDecoration(
            color: accentColor1,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 30),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (_, userState) {
              // When User data already loaded from Firebase
              // Display data in Header
              if (userState is UserLoaded) {
                return Row(
                  children: [
                    // Layout for display profile picture
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFF5F558B),
                          width: 1,
                        ),
                      ),
                      child: Stack(
                        children: [
                          SpinKitFadingCircle(
                            color: accentColor2,
                            size: 50,
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // If profile picture not set in Firebase,
                              // it will displayed as default picture (user_pic.png)
                              image: DecorationImage(
                                image: (userState.user.profilePicture == ""
                                    ? AssetImage("assets/user_pic.png")
                                    : NetworkImage(
                                        userState.user.profilePicture)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    // Layout for display Name and Balance
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          // Using MediaQuery to know width of screen
                          // to prevent overflow Name
                          // Details: MediaQuery.of(context).size.width - 2 * defaultMargin - 50 - 12 - 16
                          width: MediaQuery.of(context).size.width -
                              2 * defaultMargin -
                              78,
                          child: Text(
                            userState.user.name,
                            style: whiteTextFont.copyWith(
                              fontSize: 18,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        // Currency for display Balance
                        // Ex: IDR 100.000
                        Text(
                          // Import intl lib first in pubspec.yaml
                          NumberFormat.currency(
                                  locale: "id_ID",
                                  decimalDigits: 0,
                                  symbol: "IDR ")
                              .format(userState.user.balance),
                          style: yellowNumberFont.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  ],
                );
              } else {
                // Display SpinKit Circle when data not already loaded from Firebase
                return SpinKitFadingCircle(
                  color: accentColor2,
                  size: 50,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
