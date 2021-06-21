import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Story extends Equatable {
  final String id;
  final String storyTitle;
  final String storyContent;
  final String imageUrl;
  final DateTime postedOn;
  final String mentorId;
  final int likeCount;

  Story({
    @required this.id,
    @required this.storyTitle,
    @required this.storyContent,
    @required this.imageUrl,
    @required this.postedOn,
    @required this.mentorId,
    @required this.likeCount,
  });

  @override
  List<Object> get props => [
        id,
        storyTitle,
        storyContent,
        imageUrl,
        postedOn,
        mentorId,
        likeCount,
      ];

  // factory Story.fromMap(Map map) {
  //   return Story(
  //     id: map['id'],
  //     storyTitle: map['storyTitle'],
  //     storyContent: map['storyContent'],
  //     imageUrl: map['imageUrl'],
  //     postedOn: DateTime.parse((map['postedOn'] as String)),
  //     mentorId: map['mentorId'],
  //     likeCount: map['likeCount'],
  //   );
  // }

  // Map<String, Object> toMap() => {
  //       'id': this.id,
  //       'storyTitle': this.storyTitle,
  //       'storyContent': this.storyContent,
  //       'imageUrl': this.imageUrl,
  //       'postedOn': this.postedOn.toIso8601String(),
  //       'mentorId': this.mentorId,
  //       'likeCount': this.likeCount,
  //     };
}
