import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shott_app/models/Banner.dart';
import 'package:shott_app/models/Category.dart';
import 'package:shott_app/models/Crew.dart';

import 'package:shott_app/models/Genre.dart';



import 'package:shott_app/models/movie.dart';
import 'package:shott_app/models/subscripption.dart';
import 'package:shott_app/models/viewHistory.dart';

class APIprovider {
  final String _baseUrl = "https://api.shott.tech/api/";

  Future<List<Movie>> getVideoByCategory({String category}) async {
    List<Movie> list = [];
    String link = _baseUrl + "category/" + "$category";
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data as List;
      //print("\n\n\n\n");
      //print(rest);

      for (var item in rest) {
        Movie temp = Movie.fromJson(item);
        list.add(temp);
      }
    }
    return list;
  }

  Future<List<Movie>> getTVShow() async {
    List<Movie> list = [];
    String link = _baseUrl + "viewall_tvshow";
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["show"] as List;

      for (var item in rest) {
        Movie temp = Movie.fromJson(item);
        list.add(temp);
      }
    }
    return list;
  }

  Future<List<Crew>> getTVShowCrew({String id}) async {
    List<Crew> list = [];
    String link = _baseUrl + "viewcrew/$id";
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data as List;

      for (var item in rest) {
        Crew temp = Crew.fromJson(item);
        list.add(temp);
      }
    }
    return list;
  }

  Future<List<Crew>> getMovieCrew({String id}) async {
    List<Crew> list = [];
    String link = _baseUrl + "viewcrew_movie/$id";
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data as List;

      for (var item in rest) {
        Crew temp = Crew.fromJson(item);
        list.add(temp);
      }
    }
    return list;
  }

  Future<List<MovieBanner>> getAllBanner() async {
    List<MovieBanner> list = [];
    String link = _baseUrl + "allbanners";
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data as List;
      //print(rest);

      for (var item in rest) {
        MovieBanner temp = MovieBanner.fromJson(item);
        list.add(temp);
      }
    }
    return list;
  }

  Future<List<String>> getTotalLanguages() async {
    List<String> list = [];
    String link = _baseUrl + "languages";
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data as List;


      for (var item in rest) {
        // print(item);
        if (item["video"].length > 0) {
          list.add(item["language"]);
          print(list.length);

        }
        print(list);
        print("hi");
      }
    }
    return list;
  }

  Future<List<Movie>> getLanguages({String category}) async {
    List<Movie> list = [];
    String link = _baseUrl + "languages";
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data as List;
      //print(data);
      for (var language in rest) {
        if (language["language"] == category) {
          for (var json in language["video"]) {
            Movie temp = Movie.fromJson(json);
            list.add(temp);
          }
        }
      }
    }

    return list;
  }

  Future<List<Movie>> getFourTrend() async {
    List<Movie> list;
    String link = _baseUrl + "Trendvideos";
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data as List;
      //print(data);
      list = rest.map<Movie>((json) => Movie.fromJson(json)).toList();
    }

    return list;
  }



  Future<List<Movie>> getContinueWatching() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
   String userId = pref.getString("userId");
    List<Movie> list=[];
    print("wprking");
    String link = _baseUrl + "resume_watching/$userId";
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});

    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["watchhistory"] as List;
      print(rest.length);
      if (rest.length > 0) {
        for (var item in rest) {
          // print(item);
          Movie temp;
          temp = Movie.fromJson(item["vid"]);
          //print(temp.title);
          list.add(temp);
          print(list.length);
        }
      }
      print(list);
      return list;
    }

  }

  Future<List<Movie>> getFourLatest() async {
    List<Movie> list;
    String link = _baseUrl + "latestmovies";
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data as List;
      //print(data);
      list = rest.map<Movie>((json) => Movie.fromJson(json)).toList();
    }

    return list;
  }

  Future<List<Movie>> getAllTrend() async {
    List<Movie> list;
    String link = _baseUrl + "allTrendvideos";
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data as List;
      //print(data);
      list = rest.map<Movie>((json) => Movie.fromJson(json)).toList();
    }

    return list;
  }

  Future<List<Movie>> getAllLatest() async {
    List<Movie> list;
    String link = _baseUrl + "alllatestmovies";
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data as List;
      //print(data);
      list = rest.map<Movie>((json) => Movie.fromJson(json)).toList();
    }

    return list;
  }

  Future<List<Movie>> getTrendingVideos() async {
    List<Movie> list;
    String link = _baseUrl + "Trendvideos";
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data as List;
      list = rest.map<Movie>((json) => Movie.fromJson(json)).toList();
    }

    return list;
  }

  Future<Movie> getMovieByid(String id) async {
    Movie list;

    /// still id's of banners doe not work because those id's return null when passed with the link.
    String link = _baseUrl + "video/" + id;
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      //print(data);
      list = Movie.fromJson(data);
    }
    //print(list.id);
    //print(list.title);
    return list;
  }

  Future<List<MovieBanner>> getBannersByCategories(String categoryName) async {
    List<MovieBanner> list;
    String link = _baseUrl + "banner/$categoryName";
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data as List;
      list =
          rest.map<MovieBanner>((json) => MovieBanner.fromJson(json)).toList();
    }

    return list;
  }

  Future<Map<String, dynamic>> subscription() async {
    print("working");
    Map<String, String> price = {};

    List<String> duration1 = [
      "one_monthprice",
      "one_yearprice",
      "six_monthprice",
      "three_monthprice",
    ];
    Map<String, dynamic> list = {};

    list['price'] = price;
    list["duration"] = duration1;

    String link = _baseUrl + "payment";
    print("object");
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);

      for (var item in duration1) {
        price[item] = data["pay"][0][item].toString();
        print(price[item]);
      }
    }

    list['price'] = price;
    return list;
  }

  Future<List<sub1>> subs() async {
    print("object");
    Map<String, String> price = {};

    List<String> duration1 = [
      "one_monthprice",
      "one_yearprice",
      "six_monthprice",
      "three_monthprice",
    ];
    Map<String, dynamic> lists = {};

    lists['price'] = price;
    lists["duration"] = duration1;
    List<sub1> list;
    String link = _baseUrl + "payment";
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      print("working object");
      print(res.body);
      var data = json.decode(res.body);
      var rest = data;
      for (var item in duration1) {
        price[item] = data["pay"][0][item].toString();
        print(price[item]);
      }
      //print(data);
      list = rest.map<sub1>((json) => sub1.fromJson(json)).toList();
    }
    print(list);
    return list;
  }

  Future<List<Cat>> getAllCategories() async {
    List<Cat> list;
    String link = _baseUrl + "allcategory";
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data as List;
      //print(data);
      list = rest.map<Cat>((json) => Cat.fromJson(json)).toList();
    }

    return list;
  }

  Future<List<Movie>> getFavourite(String userId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getString("userId");
    List<Movie> list;
    print(userId);
    String link = _baseUrl + "favorites/$userId";
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      print(data);
      var rest = data as List;
      print(data);
      list = rest.map<Movie>((json) => Movie.fromJson(json)).toList();
    }

    return list;
  }

  Future<List<Movie>> getWatchLater(String userId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getString("userId");
    List<Movie> list;
    String link = _baseUrl + "ToWatch/$userId";
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data as List;
      //print("Watch Later");
      //print(data);
      list = rest.map<Movie>((json) => Movie.fromJson(json)).toList();
    }

    return list;
  }

  Future<List<Movie>> getFavouriteTv(String userId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getString("userId");

    List<Movie> list = [];
    String link = _baseUrl + "Tvfavorites/$userId";
    print(userId);
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);

      var rest = data[0]["tvshow"] as List;
      print(rest.length);

      for (var item in rest) {
        Movie temp = Movie.fromJson(item);
        // print(temp.plot);
        list.add(temp);
      }
    }
    return list;
  }

  Future<List<Movie>> getWatchLaterTv(String userId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getString("userId");
    List<Movie> list;
    String link = _baseUrl + "showWatchlist_tvshow/$userId";
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data[0]["tvshow"] as List;
      //print("Watch Later");
      //print(data);
      list = rest.map<Movie>((json) => Movie.fromJson(json)).toList();
    }

    return list;
  }

  Future<List<Genre>> getMoviesByGenre(String movieId) async {
    List<Genre> list;
    String link = _baseUrl + "videobygenre/$movieId";
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data as List;
      //print("Watch Later");
      //print(data);
      list = rest.map<Genre>((json) => Genre.fromJson(json)).toList();
    }

    return list;
  }

  Future<List<Movie>> getViewHistory(String userID) async {
    List<Movie> list;
    String link = _baseUrl + "watchhistory/$userID";
    //print(userID);
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["video"] as List;
      //print(data);
      list =
          rest.map<Movie>((json) => Movie.fromJson(json)).toList();
    }

    return list;
  }

  Future<dynamic> addToFavourite({String userId, String movieId}) async {
    String link = _baseUrl + "addtofavioret/" + movieId + "/" + userId;
    var res = await http
        .post(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      //print(data);
    }
  }

  Future<dynamic> addTowatch({String userId, String movieId}) async {
    String link = _baseUrl + "addtowatch/" + movieId + "/" + userId;
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      //print(data);
    }
  }

  Future<List<Movie>> searchList(String movieName) async {
    List<Movie> list = [];
    String link = _baseUrl + "searchmovie" + "/" + movieName;
    var res = await http
        .post(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);

      var rest = data as List;
      list = rest.map<Movie>((json) => Movie.fromJson(json)).toList();
    }
    return list;
  }
}
