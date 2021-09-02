part of 'pages.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController emailController = TextEditingController();

  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSignInPage());
        return;
      },
      child: Scaffold(
        backgroundColor: backColor,
        body: ListView(
          children: [
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
              child: Column(
                children: [
                  Stack(
                    children: [
                      InkWell(
                          onTap: () {
                            context.bloc<PageBloc>().add(GoToSignInPage());
                          },
                          child:
                              Icon(Icons.arrow_back_ios, color: Colors.white)),
                      Center(
                          child: Text("Reset Password",
                              style: themeFont.copyWith(fontSize: 20)))
                    ],
                  ),
                  SizedBox(height: 40),
                  Text(
                      "Please enter the email used during registration. \nThe password reset links are sent to that email.",
                      textAlign: TextAlign.center,
                      style: themeFont),
                  SizedBox(height: 20),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text("EMAIL",
                          style: themeFont.copyWith(fontSize: 18))),
                  SizedBox(height: 5),
                  TextField(
                    onChanged: (email) {
                      isValid = EmailValidator.validate(email);
                      setState(() {});
                    },
                    autofocus: true,
                    style: TextStyle(color: Colors.grey),
                    controller: emailController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey))),
                  ),
                  SizedBox(height: 20),
                  Container(
                      width: double.infinity,
                      height: 46,
                      child: MaterialButton(
                        color: mainColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Text("SENT",
                            style: themeFont.copyWith(
                                color: (isValid) ? Colors.white : Colors.grey,
                                fontSize: 16)),
                        disabledColor: Color(0XFFE4E4E4).withOpacity(.1),
                        onPressed: (isValid)
                            ? () async {
                                await AuthServices.resetPassword(
                                    emailController.text);

                                showSnackBar(context,
                                    "Password reset link has sent to your email");
                              }
                            : null,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
