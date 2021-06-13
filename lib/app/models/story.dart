import 'package:flutter/material.dart';

class Story {
  String id;
  String storyTitle;
  String storyContent;
  String imageUrl;
  DateTime postedOn;
  String mentorId;
  int likeCount;

  Story({
    @required this.id,
    @required this.storyTitle,
    @required this.storyContent,
    @required this.imageUrl,
    @required this.postedOn,
    @required this.mentorId,
    @required this.likeCount,
  });

  factory Story.fromMap(Map map) {
    return Story(
      id: map['id'],
      storyTitle: map['storyTitle'],
      storyContent: map['storyContent'],
      imageUrl: map['imageUrl'],
      postedOn: DateTime.parse((map['postedOn'] as String)),
      mentorId: map['mentorId'],
      likeCount: map['likeCount'],
    );
  }

  Map<String, Object> toMap() => {
        'id': this.id,
        'storyTitle': this.storyTitle,
        'storyContent': this.storyContent,
        'imageUrl': this.imageUrl,
        'postedOn': this.postedOn.toIso8601String(),
        'mentorId': this.mentorId,
        'likeCount': this.likeCount,
      };
}
