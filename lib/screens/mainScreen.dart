import 'package:flutter/material.dart';

import 'package:shott_app/constants/colors.dart';
import 'package:shott_app/constants/widgets/drawer.dart';
import 'package:shott_app/models/Category.dart';
import 'package:shott_app/services/apiProvider.dart';

import 'categoryTabs/tab.dart';

class HomeScreen extends StatefulWidget {
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  HomeScreen({
    Key key,
  }) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Tab> tabList = [];
  List<CategoryTab> categoryList = [];
  Future getAllCategories() async {
    List<Cat> list = await APIprovider().getAllCategories();
    // tabList.add(
    //   Tab(
    //     text: "Home",
    //   ),
    // );
    // categoryList.add(
    //   CategoryTab(
    //     category: "Home",
    //   ),
    // );
    for (var item in list) {
      tabList.add(
        Tab(
          text: item.name,
        ),
      );
      categoryList.add(
        CategoryTab(
          category: item.name,
        ),
      );
    }
    tabList.add(
      Tab(
        text: "TV Shows",
      ),
    );
    categoryList.add(
      CategoryTab(
        category: "TV Shows",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget._key.currentState.isDrawerOpen) {
          Navigator.of(context).pop();
          return false;
        }
        return true;
      },
      child: FutureBuilder(
        future: getAllCategories(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: white,
                  ),
                )
              : TabController(
                  tabList: tabList,
                  categoryList: categoryList,
                );
        },
      ),
    );
  }
}

class TabController extends StatelessWidget {
  TabController({this.tabList, this.categoryList});
  final List<Tab> tabList;
  final List<CategoryTab> categoryList;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabList.length,
      child: Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            backgroundColor: white,
            bottom: TabBar(
                isScrollable: true,
                labelColor: orangeColor,
                labelPadding: EdgeInsets.all(10),
                unselectedLabelColor: black,
                indicatorColor: orangeColor,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: tabList),
            centerTitle: true,
            elevation: 0,
            title: Container(
              child: Image.asset(
                "assets/shott_logo.png",
                height: 50.0,
                width: 70.0,
                alignment: Alignment.center,
              ),
            ),
            iconTheme: IconThemeData(color: orangeColor),
          ),
          drawer: Mydrawer(),
          body: TabBarView(
            children: categoryList,
          )),
    );
  }
}
