import 'package:flutter/material.dart';
import 'package:meals/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter-screen';
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  FilterScreen(this.currentFilters, this.saveFilters);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var glutenFree = false;
  var vegeratrian = false;
  var lactoseFree = false;
  var vegan = false;
  @override
  void initState() {
    glutenFree = widget.currentFilters['gluten'] as bool;
    lactoseFree = widget.currentFilters['lactose'] as bool;
    vegan =widget.currentFilters['vegan'] as bool;
    vegeratrian = widget.currentFilters['vegetarian'] as bool;
    super.initState();
  }

  Widget buildSwitchTile(
      String title, String desc, var currVal, Function(bool)? updateVal) {
    return SwitchListTile(
        title: Text(title),
        value: currVal,
        subtitle: Text(desc),
        onChanged: updateVal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: [
          IconButton(
              onPressed: () {
                final selectedmeals = {
                  'gluten': glutenFree,
                  'lactose': lactoseFree,
                  'vegan': vegan,
                  'vegetarian': vegeratrian
                };
                widget.saveFilters(selectedmeals);
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection',
                style: TextStyle(fontFamily: 'RobotoCondensed', fontSize: 20),
              )),
          Expanded(
            child: ListView(
              children: [
                buildSwitchTile(
                  'Gluten-free',
                  'only add gluten-free meals',
                  glutenFree,
                  (newVal) {
                    setState(() {
                      glutenFree = newVal;
                    });
                  },
                ),
                buildSwitchTile(
                  'Lactoser-free',
                  'only add lactose-free meals',
                  lactoseFree,
                  (newVal) {
                    setState(() {
                      lactoseFree = newVal;
                    });
                  },
                ),
                buildSwitchTile(
                  'Vegetarian',
                  'only add vegetarian meals',
                  vegeratrian,
                  (newVal) {
                    setState(() {
                      vegeratrian = newVal;
                    });
                  },
                ),
                buildSwitchTile(
                  'Vegan',
                  'only add vegan meals',
                  vegan,
                  (newVal) {
                    setState(() {
                      vegan = newVal;
                    });
                  },
                )
              ],
            ),
          )
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
