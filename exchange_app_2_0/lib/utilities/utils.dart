import 'package:exchange/widgets/news_category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/home_page.dart';
import '../screens/news_headlines_page.dart';
import '../screens/opposing_views_page.dart';
import '../screens/profile_page.dart';
import '../screens/trending_page.dart';





showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}


List<Widget> pageListing = [
  const HomePage(),
  const ProfileScreen(uid: '',),
  NewsHeadlinesScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
  const TrendingPage(),
  const OpposingViews(),
  // NewsCategories(category: ''),
];