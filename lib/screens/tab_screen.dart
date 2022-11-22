import 'package:flutter/material.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/favorites_Screen.dart';
import 'package:meals/widgets/main_drawer.dart';

import '../models/meal.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favroiteMeals;
  TabScreen(this.favroiteMeals);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
   List<Map<String, Object>>?   pages;
  int selectedPageIndex = 0;
  @override
  void initState() {
    pages=[
    {
      'page': CategoriesScreen(),
      'title': 'Categories',
    },
    {'page': FavoriteScreen(widget.favroiteMeals), 'title': 'Your favorite'}
  ];
    super.initState();
  }

  void selectedpage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
        // DefaultTabController(
        //   length: 2,
        // child:
        Scaffold(
      appBar: AppBar(
        title: Text(pages![selectedPageIndex]['title'] as String),

        // bottom: TabBar(tabs: [
        //   Tab(
        //       text: 'Categories',
        //       icon: Icon(
        //         Icons.category,
        //       )),
        //   Tab(
        //     icon: Icon(Icons.star),
        //     text: 'Favorite',
        //   )
        // ]),
      ),
      drawer: MainDrawer(),
      body: pages![selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectedpage,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            label: 'Categroy',
            icon: Icon(Icons.category),
          ),
          BottomNavigationBarItem(
            label: 'Favorite',
            icon: Icon(Icons.star),
          )
        ],
      ),
      //
      // TabBarView(
      //   children: [CategoriesScreen(), FavoriteScreen()],
      // ),
    );
    // );
  }
}
