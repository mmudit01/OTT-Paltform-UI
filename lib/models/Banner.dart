class MovieBanner {
  bool status;
  String sId;
  String title;
  String bannerimage;
  String startdate;
  String category;
  String enddate;
  String link;
  int bannid;
  int iV;

  MovieBanner(
      {this.status,
      this.sId,
      this.title,
      this.bannerimage,
      this.startdate,
      this.category,
      this.enddate,
      this.link,
      this.bannid,
      this.iV});

  factory MovieBanner.fromJson(Map<String, dynamic> json) {
    return MovieBanner(
      status: json['status'],
      sId: json['_id'],
      title: json['title'],
      bannerimage: json['bannerimage'],
      startdate: json['startdate'],
      category: json['category'],
      enddate: json['enddate'],
      link: json['link'],
      bannid: json['bannid'],
      iV: json['__v'],
    );
  }
}
