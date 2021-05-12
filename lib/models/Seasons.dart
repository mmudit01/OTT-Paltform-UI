import 'Episodes.dart';

class Seasons {
  String id;
  String name;
  List<Episodes> episodes;

  Seasons({
    this.id,
    this.name,
    this.episodes,
  });

  factory Seasons.fromJson(Map<String, dynamic> json) {
    List<Episodes> episode = [];
    for (var item in json["episode"].toList()) {
      episode.add(Episodes.fromJson(item));
    }
    return Seasons(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      episodes: episode,
    );
  }
}
