part of 'pages.dart';

class AccountConfirmationPage extends StatefulWidget {
  final RegistrationData registrationData;

  AccountConfirmationPage(this.registrationData);

  @override
  _AccountConfirmationPageState createState() =>
      _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  bool signUpProcess = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          context
              .bloc<PageBloc>()
              .add(GoToPreferencePage(widget.registrationData));
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
                  children: [
                    //note: BACK ICON & TITLE
                    Stack(
                      children: [
                        InkWell(
                          onTap: () async {
                            context.bloc<PageBloc>().add(
                                GoToPreferencePage(widget.registrationData));
                          },
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Confirmation",
                            style: themeFont.copyWith(fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 80,
                    ),

                    //note: PROFILE PREVIEW
                    Container(
                      height: 150,
                      width: 150,
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: (widget.registrationData.profilePicture !=
                                      null)
                                  ? FileImage(
                                      widget.registrationData.profilePicture)
                                  : AssetImage("assets/profile.png"),
                              fit: BoxFit.cover)),
                    ),

                    Text("Welcome,", style: themeFont.copyWith(fontSize: 18)),
                    Text(widget.registrationData.name,
                        style: themeFont.copyWith(
                            fontSize: 20, fontWeight: FontWeight.bold)),

                    SizedBox(
                      height: 80,
                    ),

                    (signUpProcess)
                        ? SpinKitChasingDots(color: mainColor, size: 46)
                        : Container(
                            width: 250,
                            height: 46,
                            child: MaterialButton(
                                color: mainColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text("Sign Up!",
                                    style: themeFont.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () async {
                                  setState(() {
                                    signUpProcess = true;
                                  });

                                  imageToUpload =
                                      widget.registrationData.profilePicture;

                                  SignInSignUpResult result =
                                      await AuthServices.signUp(
                                          widget.registrationData.email,
                                          widget.registrationData.password,
                                          widget.registrationData.name,
                                          widget
                                              .registrationData.selectedGenres,
                                          widget.registrationData.selectedYear);

                                  if (result.user == null) {
                                    setState(() {
                                      signUpProcess = false;
                                    });
                                    showSnackBar(context, result.message);
                                  }
                                }),
                          )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
