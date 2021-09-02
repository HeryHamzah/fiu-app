part of 'pages.dart';

class PreferencePage extends StatefulWidget {
  final List<String> genres = [
    "Action",
    "Animation",
    "Crime",
    "Horror",
    "Romance",
    "Western"
  ];

  final List<String> years = [
    "Old Movies",
    "2000-2010",
    "2011-2020",
    "Latest Movies",
  ];

  final RegistrationData registrationData;

  PreferencePage(this.registrationData);

  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  List<String> selectedGenre = [];
  String selectedYear = "Latest Movies";

  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     selectedGenre = widget.registrationData.selectedGenres;
  //     selectedYear = widget.registrationData.selectedYear;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.registrationData.password = "";
        context.bloc<PageBloc>().add(GoToSignUpPage(widget.registrationData));
        return;
      },
      child: Scaffold(
          body: Container(
        color: backColor,
        padding: EdgeInsets.fromLTRB(
            defaultMargin, 20, defaultMargin, defaultMargin),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //note: BACK ICON
                InkWell(
                  onTap: () async {
                    widget.registrationData.password = "";
                    context
                        .bloc<PageBloc>()
                        .add(GoToSignUpPage(widget.registrationData));
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Choose your \nfavorite genre!",
                  style: themeFont.copyWith(fontSize: 20),
                ),
                SizedBox(
                  height: 15,
                ),

                //note: GENRE
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: widget.genres
                      .map((e) => PreferenceCard(
                            e,
                            width: (MediaQuery.of(context).size.width -
                                    2 * defaultMargin -
                                    16) /
                                2,
                            isSelected: selectedGenre.contains(e),
                            onTap: () {
                              if (selectedGenre.contains(e)) {
                                setState(() {
                                  selectedGenre.remove(e);
                                });
                              } else {
                                if (selectedGenre.length < 4) {
                                  setState(() {
                                    selectedGenre.add(e);
                                  });
                                }
                              }
                            },
                          ))
                      .toList(),
                ),
                SizedBox(
                  height: 20,
                ),

                //note: YEAR
                Text(
                  "Year your favorite\n movie release?",
                  style: themeFont.copyWith(fontSize: 20),
                ),
                SizedBox(
                  height: 15,
                ),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: widget.years
                      .map((e) => PreferenceCard(
                            e,
                            width: (MediaQuery.of(context).size.width -
                                    2 * defaultMargin -
                                    16) /
                                2,
                            isSelected: selectedYear == e,
                            onTap: () {
                              if (selectedYear != e) {
                                selectedYear = e;
                              }
                              setState(() {});
                            },
                          ))
                      .toList(),
                ),
                SizedBox(
                  height: 40,
                ),

                //note: NEXT BUTTON
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 50,
                    height: 50,
                    child: MaterialButton(
                        padding: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        color: secondColor,
                        disabledColor: Color(0XFFE4E4E4).withOpacity(.1),
                        child: Center(
                          child: Icon(
                            MaterialCommunityIcons.arrow_right_bold_outline,
                            color: (selectedGenre.length == 4 &&
                                    selectedYear != "")
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
                        onPressed:
                            (selectedGenre.length == 4 && selectedYear != "")
                                ? () {
                                    widget.registrationData.selectedGenres =
                                        selectedGenre;
                                    widget.registrationData.selectedYear =
                                        selectedYear;
                                    context.bloc<PageBloc>().add(
                                        GoToAccountConfirmationPage(
                                            widget.registrationData));
                                  }
                                : null),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
