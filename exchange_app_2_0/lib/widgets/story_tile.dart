import 'package:flutter/material.dart';

import '../screens/article_view.dart';
import 'bubble_stories.dart';
import 'modal_screen.dart';







class StoryTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String? url;

  StoryTile(
      {required this.imageUrl,
        required this.title,
        required this.description,
        required this.url});

  final List people = [
    'Sheldon',
    'Bobby',
    'Cory',
    'John',
    'Anthony',
    'Osirus',
    'Socrates'
  ];


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ArticleView(newsUrl: url!),
                    ),
                  );
                },
                child: ClipRRect(
                  child: Image.network(imageUrl),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(color: Colors.black),
              ),
              Container(
                height: 100,
                child: ListView.builder(
                  itemCount: people.length,
                  itemBuilder: (context, index) {
                    return BubbleStories(
                      text: people[index],
                      onDoubleTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return  const ModalScreen(videoURL: '', videoUsername: '', uid: '',);
                            });
                        print('clicked');
                      },
                    );
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
              // Container(
              //   width: size.width,
              //   child: FollowButton(
              //     function: ,
              //     backgroundColor: Colors.blue,
              //     borderColor: Colors.white60,
              //     text: 'Reply',
              //     textColor: Colors.white,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}