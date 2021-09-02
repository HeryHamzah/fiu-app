part of 'pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 250,
              width: 250,
              child: SvgPicture.asset(
                "assets/splash.svg",
                fit: BoxFit.contain,
              ),
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/logo.png"))),
            ),
            Text(
              "Buy tickets from your favourite movie \ncinema, everywhere anytime",
              textAlign: TextAlign.center,
              style: themeFont.copyWith(fontSize: 16),
            ),
            Container(
              height: 46,
              width: 250,
              margin: EdgeInsets.only(top: 50, bottom: 8),
              child: MaterialButton(
                  color: mainColor,
                  textColor: Colors.white,
                  child: Text(
                    "Get Started",
                    style: themeFont.copyWith(
                        fontSize: 18,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: () {
                    context
                        .bloc<PageBloc>()
                        .add(GoToSignUpPage(RegistrationData()));
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: themeFont,
                ),
                InkWell(
                  onTap: () {
                    context.bloc<PageBloc>().add(GoToSignInPage());
                  },
                  child: Text(
                    "Sign In",
                    style: themeFont.copyWith(color: mainColor),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
