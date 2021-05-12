import 'Seasons.dart';

class Movie {
  String language;
  String genre;
  String age;

  String date;
  String id;
  String title;
  String thumbnail;
  String bannerimage;
  String video;
  int price;
  String category;
  String crewName;
  String crewRole;
  String desc;
  String crewimage;
  List<Seasons> seasons;
  String views;
  String plot;
  int rating;
  String parentalguidance;
  // String tvName;
  // String tvBanner;

  Movie({
    this.age,
    this.bannerimage,
    this.title,
    this.video,
    this.category,
    this.date,
    this.genre,
    this.id,
    this.language,
    this.parentalguidance,
    this.price,
    this.thumbnail,
    this.crewName,
    this.crewRole,
    this.desc,
    this.crewimage,
    this.seasons,
    this.views,
    this.plot,
    int rating,
    // this.tvName,
    // this.tvBanner
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    List<Seasons> season = [];
    Seasons temp;

    if (json["season"] != null) {
      for (var item in json["season"].toList()) {
        temp = Seasons.fromJson(item);
        print(temp.id);
        if (temp.id != null) {
          season.add(temp);
        }
      }
    }
    var ratings = json["rating"] ?? 0;
    return Movie(
      video: "https://assets.shott.tech/${json["video"] ?? ""}",
      // price: json["price"] ?? "",
      date: json["date"] ?? "",
      crewName: json["crewname"] ?? "",
      crewRole: json["crewrole"] ?? "",
      desc: json["plot"] ?? "",
      crewimage: "https://assets.shott.tech/${json["crewimage"] ?? ""}",
      id: json["_id"] ?? "",
      title: json["title"] ?? "",
      plot: json["plot"] ?? "",
      thumbnail: "https://assets.shott.tech/${json["thumbnail"] ?? ""}",
      bannerimage: "https://assets.shott.tech/${json["bannerimage"] ?? ""}",
      language: json["language"] ?? "",
      age: json["Age"] ?? "",
      parentalguidance: json["parentalguidance"] ?? "",
      category: json["category"] ?? "",
      genre: json["genre"] ?? "",
      seasons: season ?? [],
      rating: ratings.toInt(),
      views: json["views"].toString() ?? "No Views",
      // tvName: json["name"] ?? "",
      // tvBanner: json["eposide"][0]["bannerimage"] ?? "",
    );
  }
}
