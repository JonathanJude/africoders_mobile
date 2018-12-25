class ForumThread {
  int id;
  String title;
  String body;
  String slug;
  String url;
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

  ForumThread({
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
  });

  factory ForumThread.fromJson(Map<String, dynamic> json) {
    return ForumThread(
      body: json["body"],
      //category: json["category"],
      category: "Forum",
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

class Meta {
  Pagination pagination;

  Meta({
    this.pagination,
  });
}

class Pagination {
  int total;
  int count;
  int perPage;
  int currentPage;
  int totalPages;
  Links links;

  Pagination({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
    this.links,
  });
}

class Links {
  String next;

  Links({
    this.next,
  });
}
