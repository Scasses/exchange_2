import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:exchange/screens/explore_page.dart';
// import 'package:exchange/screens/home_page.dart';
// import 'package:exchange/screens/news_headlines_page.dart';
// import 'package:exchange/screens/opposing_views_page.dart';
// import 'package:exchange/screens/profile_page.dart';
// import 'package:exchange/screens/trending_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utilities/utils.dart';

class MobileScreenLayout extends StatefulWidget {
  MobileScreenLayout({Key? key, required}) : super(key: key);

@override
State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
int _page = 0;
PageController pageController = PageController();
bool isLoading = false;
var userData = {};

void pageNavigator(int page) {
pageController.jumpToPage(page);
}

void whenPageChanges(int page) {
setState(() {
_page = page;
});
}

// List<Widget> pageListing = [
//   const HomePage(),
//   const ProfileScreen(),
//   NewsHeadlinesScreen(
//     uid: FirebaseAuth.instance.currentUser!.uid,
//   ),
//   const TrendingPage(),
//   const OpposingViews(),
// ];

@override
Widget build(BuildContext context) {
return Scaffold(
body: PageView(
physics: const NeverScrollableScrollPhysics(),
controller: pageController,
onPageChanged: whenPageChanges,
children: pageListing,
),
bottomNavigationBar: BottomNavigationBar(
type: BottomNavigationBarType.fixed,
selectedItemColor: Colors.black,
backgroundColor: Colors.white60,
items: <BottomNavigationBarItem>[
BottomNavigationBarItem(
icon: Icon(
Icons.home,
color: _page == 0 ? Colors.red : Colors.white,
),
label: 'Home',
backgroundColor: Colors.white,
),
BottomNavigationBarItem(
icon: Icon(
Icons.person,
color: _page == 1 ? Colors.red : Colors.white,
),
label: 'Profile',
),
BottomNavigationBarItem(
icon: Icon(
Icons.newspaper_rounded,
color: _page == 2 ? Colors.red : Colors.white,
),
label: 'Headlines',
),
BottomNavigationBarItem(
icon: Icon(
Icons.trending_neutral_outlined,
color: _page == 3 ? Colors.red : Colors.white,
),
label: 'Trending',
),
BottomNavigationBarItem(
icon: Icon(
Icons.people_outline_outlined,
color: _page == 4 ? Colors.red : Colors.white,
),
label: 'Views',
),
],
onTap: pageNavigator,
),
);
}
}