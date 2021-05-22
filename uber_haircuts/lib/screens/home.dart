import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                  padding: const EdgeInsets.all(8.0),
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
            FilterChip(
              avatar: CircleAvatar(
                backgroundColor: Colors.grey.shade800,
              ),
              label: const Text('Category 1'),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: lightGrey,
                    boxShadow: [
                    // Here shadow is used to give an accent to the search box
                    BoxShadow(
                      color: pink1,
                      offset: Offset(2, 1),
                      blurRadius: 5
                    )
                  ]
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
          ],
        ),
      ),
      ),
    );
  }
}
