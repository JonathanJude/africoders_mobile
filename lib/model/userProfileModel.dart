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

class UserProfile {
  int id;
  String name;
  String vanity;
  String gender;
  String avatarUrl;
  String profileUrl;
  String first;
  String last;
  String bio;
  String url;
  String company;
  String location;
  String occupation;
  String phone;
  PostTime created;
  PostTime updated;
  String birthdate;

  UserProfile({
    this.id,
    this.name,
    this.vanity,
    this.gender,
    this.avatarUrl,
    this.profileUrl,
    this.first,
    this.last,
    this.bio,
    this.url,
    this.company,
    this.location,
    this.occupation,
    this.phone,
    this.created,
    this.updated,
    this.birthdate,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json){
    return UserProfile(
      avatarUrl: json['avatarUrl'],
      created: PostTime.fromJson(json["created"]),
      updated: PostTime.fromJson(json["updated"]),
      bio: json['bio'],
      birthdate: json['birthdate'],
      company: json['company'],
      first: json['first'],
      gender: json['gender'],
      id: json['id'],
      last: json['last'],
      location: json['location'],
      name: json['name'],
      occupation: json['occupation'],
      phone: json['phone'],
      profileUrl: json['profileUrl'],
      url: json['url'],
      vanity: json['vanity'],
    );
  }
}
