
import 'package:exchange_app_2_0/widgets/story_tile.dart';
import 'package:flutter/material.dart';

import '../models/article_model.dart';

import '../resources/styling.dart';
import '../utilities/camera_page.dart';
import '../utilities/news_cat_get.dart';
import 'login_button.dart';

class NewsCategories extends StatefulWidget {
  final String category;
  NewsCategories({required this.category});

  @override
  State<NewsCategories> createState() => _NewsCategoriesState();
}

class _NewsCategoriesState extends State<NewsCategories> {
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategories();
  }

  getCategories() async {
    NewsCategory newsCat = NewsCategory();
    await newsCat.getNewsCategory(widget.category);
    articles = newsCat.newsCategories;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D3541),
        title: const Row(
          children: <Widget>[
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
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
        child: Container(
          child: const CircularProgressIndicator(),
        ),
      )
          : SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: size.height,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        StoryTile(
                            imageUrl: articles[index].urlToImage!,
                            title: articles[index].title!,
                            description: articles[index].description!,
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
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}