import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_haircuts/widgets/categories_filter.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import '../common_items.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      home: Scaffold (
        backgroundColor: lightGrey,
        body: SafeArea(
        child: Column(
          children: [
            AppBar(
              elevation: 0,
              backgroundColor: lightGrey,
              title: Row(
                children: <Widget>[
                ],
              ),
              // action used to place icon to the right
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: IconButton(
                    icon: const Icon(Icons.account_circle, size: 35, color: pink1),
                    tooltip: 'View profile details',
                    onPressed: () {
                      // ADD FUNCTION TO VIEW PROFILE DETAILS
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
              child: CategoriesFilter(),
            ),
            SizedBox(height: 5,),
            // Search bar
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: pink1,
                    width: 3
                  ),
                    borderRadius: BorderRadius.circular(14),
                    color: lightGrey,
                ),
                child: ListTile(
                  title: TextField(
                    // Add search text to the search bar and remove the border
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none
                    ),
                  ),
                  // Add the search icon and colour according to the theme
                  leading: Icon(Icons.search, color: pink1, size: 25),
                ),
              ),
            ),
            ReturnText(inputText: "Available Right Now", size: 20,)
          ],
        ),
      ),
      ),
    );
  }
}
