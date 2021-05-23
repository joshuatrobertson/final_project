import 'package:flutter/cupertino.dart';
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
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (_, index){
                  return Container(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    height: 200,
                    width: 200,
                        child: Stack(
                          children:[
                            Container(
                              alignment: Alignment.center,
                              child: Image.asset("assets/images/barber01.jpg", height: 200, width: 200,
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 40.0),
                              child: Container(

                                  alignment: Alignment.bottomCenter,
                                  child: ReturnText(text: 'Barber Name', size: 20, color: white,),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 45.0, left: 6),
                              child: Row(
                                children: [
                                  ReturnText(text: '5', size: 16, color: white),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Icon(Icons.star, color: lightGrey, size: 12),
                                    ),
                                  ],
                              ),
                            ),
                          ],
                        ),
                  );
                }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
              child: Align(alignment: Alignment.centerLeft, child: ReturnText(text: 'Available Right Now', size: 20),),
            ),
            SizedBox(
              height: 2
            ),
            Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Container(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 200,
                        height: 140,
                        decoration: BoxDecoration(
                          color: lightGrey,
                          borderRadius: BorderRadius.all(
                              Radius.circular(12.0)
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 4,
                              blurRadius: 4,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: <Widget> [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.asset("assets/images/barber02.jpg", height: 140, width: 170, )
                            ),
                            ReturnText(text: 'Some text')
                          ],
                        ),

                      ),
                    );
                  })
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
