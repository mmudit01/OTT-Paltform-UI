class WatchLater {
  String id;
  String name;
  int v;
  String image;
  int price;
  String language;

  WatchLater(
      {this.id, this.name, this.v, this.image, this.price, this.language});

  factory WatchLater.fromJson(Map<String, dynamic> json) {
    return WatchLater(
        id: json['_id'],
        name: json['title'],
        v: json['__v'],
        image: "https://assets.shott.tech/" + json['bannerimage'],
        price: json['price'],
        language: json['language']);
  }
}
