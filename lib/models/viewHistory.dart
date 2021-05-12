class viewHistory {
  String id;
  String name;
  int v;
  String image;
  int price;
  String language;

  viewHistory(
      {this.id, this.name, this.v, this.image, this.price, this.language});

  factory viewHistory.fromJson(Map<String, dynamic> json) {
    return viewHistory(
        id: json['_id'],
        name: json['title'],
        v: json['__v'],
        image: "https://assets.shott.tech/" + json['bannerimage'],
        price: json['price'],
        language: json['language']);
  }
}
