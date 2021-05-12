class Crew {
  String id;
  String name;
  String crewimage;
  String role;

  Crew({
    this.id,
    this.name,
    this.crewimage,
    this.role,
  });

  factory Crew.fromJson(Map<String, dynamic> json) {
    return Crew(
      id: json["_id"] ?? "",
      name: json["crewname"] ?? "",
      crewimage:json["crewimage"] ?? "",
      role: json["crewrole"] ?? "",
    );
  }
}
