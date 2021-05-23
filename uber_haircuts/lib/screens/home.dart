import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_haircuts/widgets/available_now.dart';
import 'package:uber_haircuts/widgets/categories_filter.dart';
import 'package:uber_haircuts/widgets/featured.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import 'package:uber_haircuts/widgets/top_rated.dart';
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
        child: new SingleChildScrollView(
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
                padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
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
                      style: TextStyle(fontFamily: 'Poppins'),
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
              Container(
                height: 200,
                  child: Featured()
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 0.0),
                child: Align(alignment: Alignment.centerLeft, child: ReturnText(text: 'Haircuts Available Now', size: 17),),
              ),
              SizedBox(
                height: 2
              ),
              AvailableNow(),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                child: Align(alignment: Alignment.centerLeft, child: ReturnText(text: 'Top Rated Barbers', size: 17),),
              ),
              Container(
                  height: 200,
                  child: TopRated()
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
