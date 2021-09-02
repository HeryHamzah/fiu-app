part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final RegistrationData registrationData;

  SignUpPage(this.registrationData);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool obscurePassword = false;
  bool obscureConfirPassword = false;

  // validasiForm() {
  //   if (nameController.text.trim() == "" ||
  //       emailController.text.trim() == "" ||
  //       passwordController.text.trim() == "" ||
  //       confirmPasswordController.text.trim() == "") {
  //     showSnackBar(context, "Lengkapi Form terlebih dahulu!");
  //   } else if (!(EmailValidator.validate(emailController.text))) {
  //     showSnackBar(context, "Format Email salah");
  //   } else if (passwordController.text.length < 6) {
  //     showSnackBar(context, "Panjang password minimal 6 karakter");
  //   } else if (passwordController.text != confirmPasswordController.text) {
  //     showSnackBar(context, "Konfirmasi Password salah");
  //   } else {
  //     context.bloc<PageBloc>().add(GoToPreferencePage(widget.registrationData));
  //   }
  // }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.registrationData.name);
    emailController =
        TextEditingController(text: widget.registrationData.email);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSplashPage());
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //note: TITLE
                  Align(
                    alignment: Alignment.topLeft,
                    child: Stack(
                      children: [
                        InkWell(
                            onTap: () async {
                              context.bloc<PageBloc>().add(GoToSplashPage());
                            },
                            child: Icon(Icons.arrow_back_ios,
                                color: Colors.white70)),
                        Center(
                          child: Text(
                            "Register",
                            style: themeFont.copyWith(fontSize: 24),
                          ),
                        )
                      ],
                    ),
                  ),

                  //note: CONTENT
                  Container(
                    height: 105,
                    width: 90,
                    margin: EdgeInsets.only(top: 40, bottom: 40),
                    child: Stack(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image:
                                      (widget.registrationData.profilePicture ==
                                              null)
                                          ? AssetImage("assets/profile.png")
                                          : FileImage(widget
                                              .registrationData.profilePicture),
                                  fit: BoxFit.cover)),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () async {
                              if (widget.registrationData.profilePicture ==
                                  null) {
                                widget.registrationData.profilePicture =
                                    await getImage();
                              } else {
                                widget.registrationData.profilePicture = null;
                              }
                              setState(() {});
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color:
                                      (widget.registrationData.profilePicture ==
                                              null)
                                          ? secondColor
                                          : mainColor,
                                  shape: BoxShape.circle),
                              child: Icon(
                                (widget.registrationData.profilePicture == null)
                                    ? Icons.camera
                                    : Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  TextField(
                    controller: nameController,
                    style: TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                        hintText: "Full Name",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w500),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: emailController,
                    style: TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                        hintText: "Email",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w500),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    obscureText: obscurePassword,
                    controller: passwordController,
                    style: TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          child: Icon(
                            (obscurePassword)
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
                            color: Colors.grey, fontWeight: FontWeight.w500),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    obscureText: obscureConfirPassword,
                    controller: confirmPasswordController,
                    style: TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              obscureConfirPassword = !obscureConfirPassword;
                            });
                          },
                          child: Icon(
                            (obscureConfirPassword)
                                ? MdiIcons.eyeOffOutline
                                : MdiIcons.eyeOutline,
                            color: Colors.grey,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                        hintText: "Confirm Password",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w500),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey))),
                  ),
                  SizedBox(
                    height: 40,
                  ),

                  //note: NEXT BUTTON
                  Container(
                    width: 50,
                    height: 50,
                    child: MaterialButton(
                        padding: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        color: secondColor,
                        disabledColor: secondColor.withOpacity(.1),
                        child: Center(
                          child: Icon(
                            MaterialCommunityIcons.arrow_right_bold_outline,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          widget.registrationData.email = emailController.text;
                          widget.registrationData.name = nameController.text;
                          widget.registrationData.password =
                              passwordController.text;

                          // validasiForm();
                          if (nameController.text.trim() == "" ||
                              emailController.text.trim() == "" ||
                              passwordController.text.trim() == "" ||
                              confirmPasswordController.text.trim() == "") {
                            showSnackBar(context, "Complete the form first!");
                          } else if (!(EmailValidator.validate(
                              emailController.text))) {
                            showSnackBar(context, "Wrong email form");
                          } else if (passwordController.text.length < 6) {
                            showSnackBar(context,
                                "Password is a minimum of six character length");
                          } else if (passwordController.text !=
                              confirmPasswordController.text) {
                            showSnackBar(
                                context, "Confirm password is incorrect");
                          } else {
                            context.bloc<PageBloc>().add(
                                GoToPreferencePage(widget.registrationData));
                          }
                        }),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
