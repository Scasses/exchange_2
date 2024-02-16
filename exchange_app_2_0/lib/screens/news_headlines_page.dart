import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
import '../helper/data.dart';
import '../helper/news.dart';
import '../models/article_model.dart';
import '../models/category_model.dart';
// import '../providers/user_provider.dart';
import '../resources/AuthMethods.dart';
// import '../resources/constants.dart';
import '../resources/firestore_methods.dart';
import '../resources/styling.dart';
import '../utilities/camera_page.dart';
import '../utilities/news_cat_get.dart';
import '../utilities/utils.dart';
import '../widgets/category_tile.dart';
import '../widgets/login_button.dart';
import '../widgets/story_tile.dart';

class NewsHeadlinesScreen extends StatefulWidget {
  static const String id = 'headlines';
  final String uid;
  NewsHeadlinesScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<NewsHeadlinesScreen> createState() => _NewsHeadlinesScreenState();
}

class _NewsHeadlinesScreenState extends State<NewsHeadlinesScreen> {
  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;
  var userData = {};
  bool isLoading = false;
  XFile? _file;
  final picker = ImagePicker();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  final FirebaseAuthMethods _authMethods = FirebaseAuthMethods();

  @override
  void initState() {
    // TODO: implement initState
    categories = getCategories();
    getData();
    getNewsItems();
    super.initState();
  }

  getNewsItems() async {
    News news = News();
    await news.getNewsMediaData();
    articles = news.newsStory;
    setState(() {
      _loading = false;
    });
  }

  Future<XFile?> captureVideo() async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? video = await _picker.pickVideo(
        source: ImageSource.camera,
        maxDuration: const Duration(seconds: 30),
      );
      return video;
    } catch (e) {
      print(e); // You might want to handle the error more gracefully
      return null;
    }
  }

  // getData() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   try {
  //     var userSnap = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(widget.uid)
  //         .get();
  //     userData = userSnap.data()!;
  //     print(userData);
  //   } catch (error) {
  //     showSnackBar(error.toString(), context);
  //     print(error.toString());
  //     print('An error has occurred, Null again.');
  //   }
  //
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  getData() async {
    setState(() {
      isLoading = true;
    });

    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      userData = userSnap.data()!;
      print(userData);
      if (userData != null) {
        print('User data is not null');
      } else {
        print('It is working');
        setState(() {});
      }
    } catch (error) {
      showSnackBar(error.toString(), context);
      print(error.toString());
      print('An error has occurred, Null again.');
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final userDataProvider = Provider.of<UserProvider>(context);
    // final userData = userDataProvider.userData;
    Size size = MediaQuery.of(context).size;
    return isLoading
        ? const Center(
      child: CircularProgressIndicator(),
    )
        : Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: const Row(
                children: [
                  Text(
                    'Exchange',
                    style: kAppTitleNameStyleAppBar,
                  ),
                  Text(
                    'Headlines',
                    style: TextStyle(color: Colors.white60),
                  ),
                ],
              ),
            ),
            Text(
              userData['userName'],
              style: TextStyle(color: Colors.white60),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: _loading
            ? Center(
          child: Container(
            child: const Center(child: CircularProgressIndicator()),
          ),
        )
            : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              //Categories
              Container(
                height: 50.0,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoryTile(
                        image: categories[index].image,
                        categoryName:
                        categories[index].categoryName,
                      );
                    }),
              ),
              //Blogs
              Container(
                height: size.height,
                width: size.width,
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: size.height - 5,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                StoryTile(
                                    imageUrl:
                                    articles[index].urlToImage!,
                                    title: articles[index].title!,
                                    description: articles[index]
                                        .description!,
                                    url: articles[index].url),
                                Container(
                                  width: size.width,
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.all(8.0),
                                    child: LoginButton(
                                      color: Colors.white,
                                      title: 'Reply',
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                            const CameraPage(),
                                          ),
                                        );
                                      },
                                      width: 100.0,
                                      height: 50.0,
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}