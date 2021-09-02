part of 'pages.dart';

class EditProfilePage extends StatefulWidget {
  final User user;

  EditProfilePage(this.user);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController();

  File profileImageFile;
  String profilePath;
  bool isEdited = false;
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    profilePath = widget.user.profilePicture;
    nameController = TextEditingController(text: widget.user.name);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToProfilePage());
        return;
      },
      child: Scaffold(
        backgroundColor: backColor,
        body: Container(
          margin: EdgeInsets.fromLTRB(
              defaultMargin, 20, defaultMargin, defaultMargin),
          child: ListView(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      InkWell(
                          onTap: () {
                            context.bloc<PageBloc>().add(GoToProfilePage());
                          },
                          child:
                              Icon(Icons.arrow_back_ios, color: Colors.white)),
                      Center(
                          child: Text("Edit Your\nProfile",
                              textAlign: TextAlign.center,
                              style: themeFont.copyWith(fontSize: 20)))
                    ],
                  ),
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
                                  image: (profileImageFile != null)
                                      ? FileImage(profileImageFile)
                                      : (profilePath != "")
                                          ? NetworkImage(profilePath)
                                          : AssetImage("assets/profile.png"),
                                  fit: BoxFit.cover)),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () async {
                              if (profilePath == "") {
                                profileImageFile = await getImage();
                                if (profileImageFile != null) {
                                  profilePath = basename(profileImageFile.path);
                                }
                              } else {
                                profilePath = "";
                                profileImageFile = null;
                              }
                              setState(() {
                                isEdited = nameController.text.trim() !=
                                        widget.user.name ||
                                    profilePath != widget.user.profilePicture;
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: (profilePath != "" ||
                                          profileImageFile != null)
                                      ? mainColor
                                      : secondColor,
                                  shape: BoxShape.circle),
                              child: Icon(
                                (profilePath != "" || profileImageFile != null)
                                    ? Icons.delete
                                    : Icons.camera,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  AbsorbPointer(
                    child: TextField(
                      controller: TextEditingController(text: widget.user.id),
                      style: TextStyle(color: Colors.grey),
                      decoration: InputDecoration(
                          labelText: "User ID",
                          labelStyle: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w500),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey))),
                    ),
                  ),
                  SizedBox(height: 20),
                  AbsorbPointer(
                    child: TextField(
                      controller:
                          TextEditingController(text: widget.user.email),
                      style: TextStyle(color: Colors.grey),
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w500),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey))),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    onChanged: (name) {
                      setState(() {
                        isEdited = name.trim() != widget.user.name ||
                            profilePath != widget.user.profilePicture;
                      });
                    },
                    style: TextStyle(color: Colors.grey),
                    controller: nameController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                        hintText: "Full Name",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w500),
                        labelText: "Full Name",
                        labelStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w500),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  (isUpdating)
                      ? SpinKitChasingDots(
                          size: 50,
                          color: secondColor,
                        )
                      : Container(
                          width: 250,
                          height: 46,
                          child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              disabledColor: Color(0XFFE4E4E4).withOpacity(.1),
                              color: secondColor,
                              child: Text("Update My Profile",
                                  style: themeFont.copyWith(
                                      color: (isEdited)
                                          ? Colors.white
                                          : Colors.grey,
                                      fontSize: 16)),
                              onPressed: (isEdited)
                                  ? () async {
                                      setState(() {
                                        isUpdating = true;
                                      });

                                      if (profileImageFile != null) {
                                        profilePath =
                                            await uploadImageToFirebaseStorage(
                                                profileImageFile);
                                      }

                                      context.bloc<UserBloc>().add(UpdateUser(
                                          name: nameController.text,
                                          profilePicture: profilePath));

                                      context
                                          .bloc<PageBloc>()
                                          .add(GoToProfilePage());
                                    }
                                  : null))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
