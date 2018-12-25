class PostTime {
  String date;
  int timezoneType;
  String timezone;

  PostTime({
    this.date,
    this.timezoneType,
    this.timezone,
  });

  factory PostTime.fromJson(Map<String, dynamic> json) {
    return PostTime(
        date: json["date"],
        timezone: json["timezone"],
        timezoneType: json["timezoneType"]);
  }
}

class User {
  int id;
  String name;
  String vanity;
  String avatarUrl;
  String profileUrl;

  User({
    this.id,
    this.name,
    this.vanity,
    this.avatarUrl,
    this.profileUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        avatarUrl: json["avatarUrl"],
        id: json["id"],
        name: json["name"],
        profileUrl: json["profileUrl"],
        vanity: json["vanity"]);
  }
}

/* class Comment {
  int id;
  String body;
  String slug;
  int likes;
  int dislikes;
  int shares;
  User user;
  String views;
  PostTime created;
  PostTime updated;

  Comment({
    this.id,
    this.body,
    this.slug,
    this.likes,
    this.dislikes,
    this.shares,
    this.user,
    this.views,
    this.created,
    this.updated,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      body: json["body"],
      created: PostTime.fromJson(json["created"]),
      dislikes: json["dislikes"],
      id: json["id"],
      likes: json["likes"],
      shares: json["shares"],
      slug: json["slug"],
      updated: PostTime.fromJson(json["updated"]),
      user: User.fromJson(json["user"]),
      views: json["views"],
    );
  }
} */

class JobAd {
  int id;
  String title;
  String body;
  String slug;
  dynamic url;
  int likes;
  int dislikes;
  int shares;
  String views;
  String replies;
  String category;
  PostTime created;
  PostTime updated;
  String published;
  User user;
  //List<Comment> comment;

  JobAd({
    this.id,
    this.title,
    this.body,
    this.slug,
    this.url,
    this.likes,
    this.dislikes,
    this.shares,
    this.views,
    this.replies,
    this.category,
    this.created,
    this.updated,
    this.published,
    this.user,
    //this.comment,
  });

  factory JobAd.fromJson(Map<String, dynamic> json) {
/*     final list = json["comment"]["data"].cast<Map<String, dynamic>>();
    final commentsList = list.map<Comment>((json) {
      return Comment.fromJson(json);
    }).toList(); */

    return JobAd(
      body: json["body"],
      //category: json["category"],
      category: "JobAd",
      //comment: commentsList,
      created: PostTime.fromJson(json["created"]),
      dislikes: json["dislikes"],
      id: json["id"],
      likes: json["likes"],
      published: json["published"],
      replies: json["replies"],
      shares: json["shares"],
      slug: json["slug"],
      title: json["title"],
      updated: PostTime.fromJson(json["updated"]),
      url: json["url"],
      user: User.fromJson(json["user"]),
      views: json["views"],
    );
  }
}
