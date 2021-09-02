part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obsecureText = true;
  bool signInProcess = false;
  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSplashPage());
        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: backColor,
            ),
            SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        //note: ICON BACK
                        InkWell(
                          onTap: () async {
                            context.bloc<PageBloc>().add(GoToSplashPage());
                          },
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: EdgeInsets.only(top: 20, bottom: 40),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ),
                        //note: TEXT
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Welcome back.\nThe cinema is waiting for you!",
                            style: themeFont.copyWith(fontSize: 22),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),

                        //note: TEXTFIELD
                        TextField(
                          onChanged: (email) {
                            isValid = EmailValidator.validate(email) &&
                                passwordController.text.length > 0;
                            setState(() {});
                          },
                          style: TextStyle(color: Colors.grey),
                          controller: emailController,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.grey)),
                              hintText: "Email",
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.grey))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          onChanged: (password) {
                            isValid =
                                EmailValidator.validate(emailController.text) &&
                                    password.length > 0;
                            setState(() {});
                          },
                          obscureText: obsecureText,
                          style: TextStyle(color: Colors.grey),
                          controller: passwordController,
                          decoration: InputDecoration(
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    obsecureText = !obsecureText;
                                  });
                                },
                                child: Icon(
                                  (obsecureText)
                                      ? MdiIcons.eyeOffOutline
                                      : MdiIcons.eyeOutline,
                                  color: Colors.grey,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.grey)),
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.grey))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "Forgot Password? ",
                              style: themeFont,
                            ),
                            InkWell(
                              onTap: () {
                                context
                                    .bloc<PageBloc>()
                                    .add(GoToResetPasswordPage());
                              },
                              child: Text("Reset Password",
                                  style: themeFont.copyWith(color: mainColor)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 80,
                        ),

                        //note: BUTTON
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Start fresh now? ",
                              style: themeFont,
                            ),
                            InkWell(
                              onTap: () async {
                                context
                                    .bloc<PageBloc>()
                                    .add(GoToSignUpPage(RegistrationData()));
                              },
                              child: Text(
                                "Register",
                                style: themeFont.copyWith(color: mainColor),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        (signInProcess)
                            ? SpinKitChasingDots(color: mainColor, size: 46)
                            : Container(
                                width: double.infinity,
                                height: 46,
                                child: MaterialButton(
                                    disabledColor:
                                        Color(0XFFE4E4E4).withOpacity(.1),
                                    color: mainColor,
                                    textColor: Colors.white,
                                    child: Text(
                                      "Sign In",
                                      style: themeFont.copyWith(
                                          color: (isValid)
                                              ? Colors.white
                                              : Colors.grey,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    onPressed: (isValid)
                                        ? () async {
                                            setState(() {
                                              signInProcess = true;
                                            });

                                            SignInSignUpResult result =
                                                await AuthServices.signIn(
                                                    emailController.text,
                                                    passwordController.text);

                                            if (result.user == null) {
                                              showSnackBar(
                                                  context, result.message);
                                              setState(() {
                                                signInProcess = false;
                                              });
                                            }
                                          }
                                        : null),
                              )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
