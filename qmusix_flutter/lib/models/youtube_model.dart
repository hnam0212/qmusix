class YoutubeModel {
  String? title;
  String? thumbnail;
  String? id;
  String? channelTitle;
  String? publishedAt;
  String? description;

  YoutubeModel({
    this.title,
    this.thumbnail,
    this.id,
    this.channelTitle,
    this.publishedAt,
    this.description,
  });

  factory YoutubeModel.fromJson(Map<String, dynamic> json) {
    return YoutubeModel(
      title: json['snippet']['title'],
      thumbnail: json['snippet']['thumbnails']['high']['url'],
      id: json['id']['videoId'],
      channelTitle: json['snippet']['channelTitle'],
      publishedAt: json['snippet']['publishedAt'],
      description: json['snippet']['description'],
    );
  }
}
