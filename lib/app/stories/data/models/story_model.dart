import 'package:flutter/foundation.dart';
import 'package:maser/app/stories/domain/entities/story.dart';

class StoryModel extends Story {
  StoryModel({
    @required String id,
    @required String storyTitle,
    @required String storyContent,
    @required String imageUrl,
    @required DateTime postedOn,
    @required String mentorId,
    @required int likeCount,
  }) : super(
          id: id,
          storyTitle: storyTitle,
          storyContent: storyContent,
          imageUrl: imageUrl,
          postedOn: postedOn,
          mentorId: mentorId,
          likeCount: likeCount,
        );

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['id'],
      storyTitle: json['storyTitle'],
      storyContent: json['storyContent'],
      imageUrl: json['imageUrl'],
      postedOn: DateTime.parse((json['postedOn'] as String)),
      mentorId: json['mentorId'],
      likeCount: json['likeCount'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'storyTitle': this.storyTitle,
        'storyContent': this.storyContent,
        'imageUrl': this.imageUrl,
        'postedOn': this.postedOn.toIso8601String(),
        'mentorId': this.mentorId,
        'likeCount': this.likeCount,
      };
}
