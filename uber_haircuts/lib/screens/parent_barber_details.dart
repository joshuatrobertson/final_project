import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_haircuts/models/barber.dart';
import 'package:uber_haircuts/models/parent_barber.dart';
import 'package:uber_haircuts/providers/authenticate.dart';
import 'package:uber_haircuts/providers/parent_barbers.dart';
import 'package:uber_haircuts/screens/barber_details.dart';
import 'package:uber_haircuts/screens/product_list.dart';
import 'package:uber_haircuts/widgets/navigate.dart';
import 'package:uber_haircuts/widgets/return_image.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import '../theme/main_theme.dart';
import 'cart.dart';

class ParentBarberDetails extends StatefulWidget {
  final List<ParentBarberModel> parents;
  final ParentBarbersProvider provider;

  createState() => _ParentBarberDetailsState();

  ParentBarberDetails({@required this.parents, this.provider});



}

class _ParentBarberDetailsState extends State<ParentBarberDetails> {
  int _currentNav = 0;

  @override
    Widget build(BuildContext context) {
    AuthenticateProvider _user = Provider.of<AuthenticateProvider>(context);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: lightGrey,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined, color: theme,),
            onPressed: () {Navigator.pop(context);},
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_basket, color: theme,),
              onPressed: () {
                if (_user.userModel.cart != null && _user.userModel.cart.isNotEmpty) {
                  navigateToScreen(context, Cart());
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: ReturnText(text: "Basket Empty", color: white,)));
                }
              },
            )
          ],
        ),
        body: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Stack(
                children:[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                    child: Container(
                      child: SizedBox(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: widget.parents.length,
                            itemBuilder: (_, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    navigateToScreen(
                                        _, BarberDetails(parentBarbersProvider: widget.provider, parentBarberModel: widget.parents[index]));
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: lightGrey,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6.0)
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.1),
                                              spreadRadius: 8,
                                              blurRadius: 8,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  8.0, 8.0, 8.0, 0),
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(6.0),
                                                  child: ReturnImage(image: widget.parents[index].image, width: 150, height: 100)
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 4, left: 10),
                                              child:
                                              Container(
                                                width: 150,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    ReturnText(text: widget.parents[index].name,
                                                      size: 16,
                                                      fontWeight: FontWeight.bold,
                                                      align: TextAlign.left,),
                                                    Row(children:[
                                                    ReturnText(text: widget.parents[index].rating.toString(), size: 20, color: black, fontWeight: FontWeight.w600,),
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 8.0),
                                                      child: Icon(Icons.star, color: theme, size: 14),
                                                    )]
                                                    )],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                      ),
                                      Expanded(
                                        child:
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: ReturnText(text: '"' + widget.parents[index].description + '"', size: 10, color: black),
                                              ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                ),
                  ),
                ]),
            ),
          ),
        ),
      ),
    );
  }
}



