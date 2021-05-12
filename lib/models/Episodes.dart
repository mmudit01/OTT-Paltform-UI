class Episodes {
  String id;
  String name;
  String video;
  String image;
  Episodes({
    this.id,
    this.name,
    this.video,
    this.image
  });

  factory Episodes.fromJson(Map<String, dynamic> json) {
    return Episodes(
      id: json["_id"] ?? "",
      video: json["video"] ?? "",
      name: json["name"] ?? "",
      image: json["bannerimage"] ?? "",
    );
  }
}
