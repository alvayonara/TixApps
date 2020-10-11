part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Set bottom navigation bar
  int bottomNavBarIndex;

  // Set page controller based on index of bottom nav bar
  PageController pageController;

  @override
  void initState() {
    super.initState();

    // Initial index = 0 in New Movies page
    bottomNavBarIndex = 0;

    // Initial page controller in New Movies page
    pageController = PageController(initialPage: bottomNavBarIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Stack 1 -> For status bar color
          Container(
            color: accentColor1,
          ),
          // Stack 2 -> For main page exclude status bar
          SafeArea(
            child: Container(
              color: Color(0xFFF6F7F9),
            ),
          ),
          // Stack 3 -> Change Page based on bottom navigation clicked
          PageView(
            controller: pageController,
            children: [
              // Index 0 -> New Movies
              MoviePage(),
              // Index 1 -> My Ticket
              Center(
                child: Text("Page My Ticket"),
              ),
            ],
            // Using setState to change Page based on index value (bottom nav bar index)
            onPageChanged: (index) {
              setState(() {
                bottomNavBarIndex = index;
              });
            },
          ),
          // Stack 4 -> For bottom navigation layout
          createCustomBottomNavBar(),
          // Stack 5 -> For add wallet button above bottom navigaton
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 46,
              width: 46,
              margin: EdgeInsets.only(bottom: 42),
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: accentColor2,
                child: SizedBox(
                  height: 26,
                  width: 26,
                  child: Icon(
                    MdiIcons.walletPlus,
                    color: Colors.black.withOpacity(0.54),
                  ),
                ),
                onPressed: () {
                  // Temporary function: use for SignOut account
                  // Return to Initial State
                  context.bloc<UserBloc>().add(SignOut());
                  // Sign Out from Firebase
                  AuthServices.signOut();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  // Widget for bottom navigation
  Widget createCustomBottomNavBar() => Align(
        alignment: Alignment.bottomCenter,
        child: ClipPath(
          clipper: BottomNavBarClipper(),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              selectedItemColor: mainColor,
              unselectedItemColor: Color(0xFFE5E5E5),
              // Set current index based on bottomNavBarIndex value
              currentIndex: bottomNavBarIndex,
              items: [
                // Index 0 nav bar item (New Movies)
                BottomNavigationBarItem(
                  title: Text(
                    "New Movies",
                    style: GoogleFonts.raleway(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  icon: Container(
                    margin: EdgeInsets.only(
                      bottom: 6,
                    ),
                    height: 20,
                    child: Image.asset(
                      (bottomNavBarIndex == 0)
                          ? "assets/ic_movie.png"
                          : "assets/ic_movie_grey.png",
                    ),
                  ),
                ),
                // Index 1 nav bar item (My Tickets)
                BottomNavigationBarItem(
                  title: Text(
                    "My Tickets",
                    style: GoogleFonts.raleway(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  icon: Container(
                    margin: EdgeInsets.only(
                      bottom: 6,
                    ),
                    height: 20,
                    child: Image.asset(
                      (bottomNavBarIndex == 1)
                          ? "assets/ic_tickets.png"
                          : "assets/ic_tickets_grey.png",
                    ),
                  ),
                ),
              ],
              onTap: (index) {
                setState(() {
                  bottomNavBarIndex = index;

                  // When bottom nav bar clicked, page will load based on index bottom nav bar selected
                  pageController.jumpToPage(index);
                });
              },
            ),
          ),
        ),
      );
}

// Clipper for bottom navigation
class BottomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width / 2 - 28, 0);
    path.quadraticBezierTo(size.width / 2 - 28, 33, size.width / 2, 33);
    path.quadraticBezierTo(size.width / 2 + 28, 33, size.width / 2 + 28, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}
