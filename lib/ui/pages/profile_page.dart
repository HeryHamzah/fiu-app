part of "pages.dart";

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
        backgroundColor: backColor,
        body: Container(
          margin: EdgeInsets.fromLTRB(
              defaultMargin, 40, defaultMargin, defaultMargin),
          child: ListView(
            children: [
              BlocBuilder<UserBloc, UserState>(
                builder: (_, userState) {
                  if (userState is UserLoaded) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              margin: EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                      image: (userState.user.profilePicture ==
                                              "")
                                          ? AssetImage("assets/profile.png")
                                          : NetworkImage(
                                              userState.user.profilePicture),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width -
                                  2 * defaultMargin -
                                  60 -
                                  20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userState.user.name,
                                    style: themeFont.copyWith(fontSize: 16),
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(userState.user.email,
                                      style: themeFont.copyWith(
                                          color: Colors.white54))
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          color: Colors.white10,
                          height: 2,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          onTap: () {
                            context
                                .bloc<PageBloc>()
                                .add(GoToEditProfilePage(userState.user));
                          },
                          leading:
                              Image.asset("assets/icons8-male-user-30.png"),
                          title: Text("Edit Profile", style: themeFont),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            context
                                .bloc<PageBloc>()
                                .add(GoToMyWalletPage(GoToProfilePage()));
                          },
                          leading: Image.asset("assets/icons8-wallet-30.png"),
                          title: Text("My Wallet", style: themeFont),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            context
                                .bloc<PageBloc>()
                                .add(GoToFavoriteMoviesPage());
                          },
                          leading:
                              Image.asset("assets/icons8-film-reel-30.png"),
                          title: Text("My Favorite Movie", style: themeFont),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        ListTile(
                          leading:
                              Image.asset("assets/icons8-thumbs-up-30.png"),
                          title: Text("Rate App", style: themeFont),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        ListTile(
                          leading: Image.asset("assets/icons8-info-30.png"),
                          title: Text("About Us", style: themeFont),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        Divider(
                          color: Colors.white10,
                          height: 2,
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        Container(
                          width: 250,
                          height: 46,
                          child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              color: mainColor,
                              child: Text("Sign Out",
                                  style: themeFont.copyWith(fontSize: 16)),
                              onPressed: () async {
                                await AuthServices.signOut();
                                context.bloc<UserBloc>().add(UserSignOut());
                              }),
                        )
                      ],
                    );
                  } else {
                    return Center(
                      child: SpinKitChasingDots(color: mainColor, size: 50),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
