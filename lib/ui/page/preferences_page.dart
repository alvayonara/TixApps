part of 'pages.dart';

class PreferencePage extends StatefulWidget {
  // List of genres
  final List<String> genres = [
    "Horror",
    "Music",
    "Action",
    "Drama",
    "War",
    "Crime"
  ];
  // List of languages
  final List<String> languages = ["Bahasa", "English", "Japanese", "Korean"];
  // To pass registration data from sign up page
  final RegistrationData registrationData;

  PreferencePage(this.registrationData);

  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  // Save genres selected to list
  List<String> selectedGenres = [];
  // Save language selected
  String selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    // Implement WillPopScope() in Scaffold()
    // When click Back -> to Sign Up page
    return WillPopScope(
      onWillPop: () async {
        // Set password data to null in Registration Page
        widget.registrationData.password = "";

        // Load Registration Page
        context
            .bloc<PageBloc>()
            .add(GoToRegistrationPage(widget.registrationData));

        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display arrow back to previous page (Registration Page)
                  Container(
                    height: 56,
                    margin: EdgeInsets.only(
                      top: 20,
                      bottom: 4,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        // Set password data to null in Registration Page
                        widget.registrationData.password = "";

                        // Load Registration Page
                        context
                            .bloc<PageBloc>()
                            .add(GoToRegistrationPage(widget.registrationData));
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                  Text(
                    "Select Your Four\nFavorite Genre",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  // Display List of Genres
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: generateGenreWidget(context),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Generate List of Genres
  List<Widget> generateGenreWidget(BuildContext context) {
    // Define width of Selectable Box (Genre)
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    // e -> element of list genres (genre text)
    // e value must assign to SelectableBox() (NOT NULL/NOT OPTIONAL value)
    return widget.genres
        .map((e) => SelectableBox(
              e,
              width: width,
              // If selected genre same
              isSelected: selectedGenres.contains(e),
              onTap: () {
                onSelectGenre(e);
              },
            ))
        .toList();
  }

  void onSelectGenre(String genre) {
    // If list of genre contain of selected genre then remove it genre from
    if (selectedGenres.contains(genre)) {
      // Remove selected genre from list
      setState(() {
        selectedGenres.remove(genre);
      });
    } else {
      // Constraint: genre maximum to be selected is 4
      if (selectedGenres.length < 4) {
        // Genre can be added to list
        setState(() {
          selectedGenres.add(genre);
        });
      }
    }
  }
}
