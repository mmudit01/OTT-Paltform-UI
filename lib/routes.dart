import 'package:flutter/material.dart';
import 'package:shott_app/SubscriptionScreenTest.dart';
import 'package:shott_app/screens/FavAndWatchTabs/FavTab.dart';
import 'package:shott_app/screens/FavAndWatchTabs/WatchTab.dart';
import 'package:shott_app/screens/TvShows/AllTvShows.dart';
import 'package:shott_app/screens/Favorites.dart';
import 'package:shott_app/screens/LatestVideos.dart';
import 'package:shott_app/screens/LoginSignupFromDrawer/signUp_page.dart';
import 'package:shott_app/screens/SearchResult.dart';
import 'package:shott_app/screens/SignOut.dart';
import 'package:shott_app/screens/SubscriptionScreen.dart';
import 'package:shott_app/screens/TrendingVideos.dart';
import 'package:shott_app/screens/TvShows/TvDetails.dart';
import 'package:shott_app/screens/ViewHistory.dart';
import 'package:shott_app/screens/UnderDevelopment.dart';
import 'package:shott_app/screens/WatchLater.dart';
import 'package:shott_app/screens/change_password_page.dart';
import 'package:shott_app/screens/genre.dart';
import 'package:shott_app/screens/payment_details.dart';
import 'package:shott_app/screens/playVideo.dart';

import 'package:shott_app/screens/profile_screen.dart';
import 'package:shott_app/screens/signUp_page.dart';
import 'package:shott_app/screens/movie_Details.dart';
import 'package:shott_app/screens/sub/SubscriptionDrawer.dart';
import 'package:shott_app/services/play.dart';
import 'package:shott_app/videoPlayer/subtitleVideoPlayer.dart';

import 'screens/mainScreen.dart';
import 'screens/pages _of_type.dart';
import 'screens/signIn_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case ('/'):
        return MaterialPageRoute(builder: (_) => HomeScreen());
        break;
      case ('/Recommended'):
        return MaterialPageRoute(
            builder: (_) => Pages(
                  type: args,
                ));
        break;
      case ('/Trending'):
        return MaterialPageRoute(
            builder: (_) => Pages(
                  type: args,
                ));
        break;
      case ('/New Arrivals'):
        return MaterialPageRoute(
            builder: (_) => Pages(
                  type: args,
                ));
        break;
      case ('/Categories'):
        return MaterialPageRoute(builder: (_) => Genre());
        break;
      case ('/Coming Soon'):
        return MaterialPageRoute(
            builder: (_) => Pages(
                  type: args,
                ));
        break;
      case ('/Favorites'):
        return MaterialPageRoute(builder: (_) => FavTab());
        break;
      case ('/To Watch'):
        return MaterialPageRoute(builder: (_) => WatchTab());
        break;
      case ('/movieDetails'):
        return MaterialPageRoute(
            builder: (_) => MovieDetails(
                  authenticated: args,
                ));
        break;
      case ('/signIn'):
        return MaterialPageRoute(
            builder: (_) => SignInPage(
                  movie: args,
                ));
        break;
      case ('/signUp'):
        return MaterialPageRoute(
            builder: (_) => SignUpPage(
                  movie: args,
                ));
        break;
      case ('/payment'):
        return MaterialPageRoute(
            builder: (_) => PaymentStatus(
                  movieid: args,
                ));
        break;
      case ('/playVideo'):
        return MaterialPageRoute(
            builder: (_) => PlayWithSubtitles(
                  args,args
                ));
        break;
      case ('/signUp'):
        return MaterialPageRoute(builder: (_) => SignInPage());
        break;
      case ('/signOut'):
        return MaterialPageRoute(builder: (_) => SignOutPage());
        break;
      case ('/underDevelopment'):
        return MaterialPageRoute(
            builder: (_) => DevelopmentScreen("Under Development"));
        break;
      case ('/subscription'):
        return MaterialPageRoute(builder: (_) => subDrawer());
        break;

      case ('/changePassword'):
        return MaterialPageRoute(builder: (_) => ChangePasswordPage());
        break;

      case ('/history'):
        return MaterialPageRoute(builder: (_) => History());
        break;

      case ('/profile'):
        return MaterialPageRoute(builder: (_) => ProfilePage());
        break;

      case ('/signindrawer'):
        return MaterialPageRoute(builder: (_) => SignUpPageFromDrawer());
        break;
      case ('/search_result'):
        return MaterialPageRoute(
            builder: (_) => SearchResults(
                  searchItem: args,
                ));
        break;
      case ('/latest'):
        return MaterialPageRoute(builder: (_) => LatestVideos());
        break;
      case ('/trending'):
        return MaterialPageRoute(builder: (_) => TrendingVideos());
        break;
      case ('/tvShows'):
        return MaterialPageRoute(builder: (_) => AllTvShows());
        break;
      case ('/individualTV'):
        return MaterialPageRoute(builder: (_) => TvDetailsPage());
        break;
      // case ('/wrapper'):
      //   return MaterialPageRoute(builder: (_) => Wrapper());
      //   break;
      // default:
      //   return MaterialPageRoute(builder: (_) => SignPage());
    }
  }
}
