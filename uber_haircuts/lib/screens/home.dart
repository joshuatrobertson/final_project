import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_haircuts/models/parent_barber.dart';
import 'package:uber_haircuts/providers/authenticate.dart';
import 'package:uber_haircuts/providers/parent_barbers.dart';
import 'package:uber_haircuts/screens/barber_details.dart';
import 'package:uber_haircuts/screens/parent_barber_details.dart';
import 'package:uber_haircuts/screens/user_orders.dart';
import 'package:uber_haircuts/widgets/available_now.dart';
import 'package:uber_haircuts/widgets/categories_filter.dart';
import 'package:uber_haircuts/widgets/featured.dart';
import 'package:uber_haircuts/widgets/navigate.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import 'package:uber_haircuts/widgets/side_bar.dart';
import 'package:uber_haircuts/widgets/top_rated.dart';
import '../theme/main_theme.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

import 'account.dart';


class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);


  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  int _currentIndex = 0;
  final List<Widget> _screens = [
    Home(),
    Account(),
    UserOrders()
  ];


  @override
  Widget build(BuildContext context) {

    ParentBarbersProvider _barberProvider = Provider.of<ParentBarbersProvider>(context);
    ParentBarberModel _parentBarbers;

    return MaterialApp (
      home: Scaffold (
        drawer: Drawer(
          child: SideBar(),
        ),
        backgroundColor: lightGrey,
        body: SafeArea(
        child: new SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                iconTheme: IconThemeData(color: theme),
                elevation: 0,
                backgroundColor: lightGrey,
                title: Row(
                  children: <Widget>[
                  ],
                ),
                // action used to place icon to the right
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: IconButton(
                      icon: const Icon(Icons.exit_to_app_outlined, color: theme),
                      onPressed: () async {
                          context.read<Authenticate>().signOut();
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
                      color: Colors.black87,
                      width: 2
                    ),
                      borderRadius: BorderRadius.circular(14),
                      color: lightGrey,
                  ),
                  child: ListTile(
                    title: TextField(
                      onSubmitted: (text) {
                        // Search through parent barbers
                        List<ParentBarberModel> newParents = _barberProvider.allParents.where((barber) =>
                        barber.name.toLowerCase().contains(text) ? true : false ).toList();
                        if (newParents.isNotEmpty) {
                          navigateToScreen(context, ParentBarberDetails(parents: newParents, provider: _barberProvider));
                        }
                      },
                      style: TextStyle(fontFamily: 'Poppins'),
                      // Add search text to the search bar and remove the border
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none
                      ),
                    ),
                    // Add the search icon and colour according to the theme
                    leading: Icon(Icons.search, color: accent_1, size: 25),
                  ),
                ),
              ),
              Container(
                height: 200,
                  child: Featured()
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                child: Align(alignment: Alignment.centerLeft, child: ReturnText(text: 'Barbers Available Now', size: 17),),
              ),
              SizedBox(
                height: 2
              ),
              AvailableNow(),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
                child: Align(alignment: Alignment.bottomLeft, child: ReturnText(text: 'Top Rated Barbers', size: 17),),
              ),
              Container(
                  height: 140,
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



