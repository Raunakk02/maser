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
}
