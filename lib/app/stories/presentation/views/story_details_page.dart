import 'package:flutter/material.dart';
import 'package:maser/app/stories/domain/entities/story.dart';
import 'package:maser/core/managers/theme/app_colors.dart';
import 'package:maser/core/models/user.dart';

class StoryDetailsPage extends StatelessWidget {
  final Story story;
  final User user;
  const StoryDetailsPage({Key key, @required this.story, @required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            title: Text(story.storyTitle),
            floating: true,
            centerTitle: true,
            elevation: 0,
            flexibleSpace: Stack(
              children: [
                Positioned(
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        story.imageUrl,
                      ),
                      errorBuilder: (_, __, ___) => Center(
                        child: Icon(
                          Icons.image_rounded,
                          color: Colors.grey,
                          size: 100,
                        ),
                      ),
                    ),
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0),
                Positioned(
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: ThemeData.light().scaffoldBackgroundColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(50),
                      ),
                    ),
                  ),
                  bottom: -1,
                  left: 0,
                  right: 0,
                ),
              ],
            ),
            expandedHeight: 200,
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  height: 60,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Chip(
                      avatar: CircleAvatar(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.grass,
                        child: Icon(Icons.thumb_up_alt),
                      ),
                      label: Text(story.likeCount.toString()),
                      backgroundColor: AppColors.pastel_grey,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Posted By:\t',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.sea_blue,
                          ),
                          children: [
                            TextSpan(
                              text: user.name,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        story.postedOn.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Text(story.storyContent),
                    ],
                  ),
                ),
                Container(
                  height: 700,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
