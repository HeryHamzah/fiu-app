part of 'pages.dart';

class MainPage extends StatefulWidget {
  final int index;
  final int tabIndex;

  MainPage({this.index, this.tabIndex});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
    pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
              pageController.jumpToPage(_currentIndex);
            },
            controller: pageController,
            children: [HomePage(), MyTicketsPage(widget.tabIndex)],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: backColor,
          selectedItemColor: mainColor,
          unselectedItemColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            pageController.jumpToPage(_currentIndex);
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  MdiIcons.movie,
                ),
                label: "Movies"),
            BottomNavigationBarItem(
                icon: Icon(MdiIcons.ticket), label: "My Tickets"),
          ]),
    );
  }
}
