class Cat {
  String id;
  String name;
  int v;
  String image;

  Cat({
    this.id,
    this.name,
    this.v,
    this.image,
  });

  factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      id: json['_id'],
      name: json['category'],
      v: json['__v'],
      image: json['thumbnail'],
    );
  }
}
