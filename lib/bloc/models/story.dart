class Story {
  final String storyName;
  final String storyPictureUrl;

  Story({
    required this.storyName,
    required this.storyPictureUrl,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      storyName: json['storyName'],
      storyPictureUrl: json['storyPictureUrl'],
    );
  }
}

class StartedStory extends Story {
  final String chapterName;
  final double progress;

  StartedStory({
    required this.chapterName,
    required this.progress,
    required super.storyName,
    required super.storyPictureUrl,
  });

  factory StartedStory.fromJson(Map<String, dynamic> json) {
    return StartedStory(
      chapterName: json['chapterName'],
      progress: json['progress'],
      storyName: json['storyName'],
      storyPictureUrl: json['pictureUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chapterName': chapterName,
      'progress': progress,
      'storyName': storyName,
      'pictureUrl': storyPictureUrl,
    };
  }
}
