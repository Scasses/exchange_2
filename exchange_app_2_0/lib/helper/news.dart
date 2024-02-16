import 'dart:convert';
import '../models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> newsStory = [];

  String url =
      "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=7b9bbbb58e4341bb8f5055b8520aa80d";

  Future<dynamic> getNewsMediaData() async {
    var response = await http.get(
      Uri.parse(url),
    );
    var jsonData = jsonDecode(response.body);
    print(jsonData);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
          );
          newsStory.add(articleModel);
          return newsStory;
        } else {
          print(response.statusCode);
        }
      });
    }
  }
}