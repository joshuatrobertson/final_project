import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_haircuts/helpers/navigate.dart';
import 'package:uber_haircuts/models/barber.dart';
import 'package:uber_haircuts/models/parent_barber.dart';
import 'package:uber_haircuts/providers/parent_barbers.dart';
import 'package:uber_haircuts/screens/product_list.dart';
import 'package:uber_haircuts/widgets/return_image.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import '../theme/main_theme.dart';
import 'cart.dart';

class BarberDetails extends StatefulWidget {
  final ParentBarbersProvider parentBarbersProvider;
  final ParentBarberModel parentBarberModel;

  createState() => _BarberDetailsState();

  BarberDetails({@required this.parentBarbersProvider, @required this.parentBarberModel});



}

class _BarberDetailsState extends State<BarberDetails> {
  int _currentNav = 0;
  @override
    Widget build(BuildContext context) {
    // Fetch only the barbers which have the parent barber ID
    List<BarberModel> _barbers = widget.parentBarbersProvider.barbers.where((barber) =>
    barber.parentBarberID == widget.parentBarberModel.id).toList();

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
                navigateToScreen(context, Cart());
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
                            itemCount: _barbers.length,
                            itemBuilder: (_, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    navigateToScreen(
                                        _, ProductList(parentBarbersProvider: widget.parentBarbersProvider, barberModel: widget.parentBarbersProvider.barbers[index]));
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
                                                  child: ReturnImage(image: _barbers[index].image, width: 150, height: 100)
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
                                                    ReturnText(text: _barbers[index].firstName,
                                                      size: 16,
                                                      fontWeight: FontWeight.bold,
                                                      align: TextAlign.left,),
                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          ReturnText(
                                                              text: widget.parentBarberModel.name,
                                                              color: Colors.black54,
                                                              size: 10),
                                                          ReturnText(text: _barbers[index].rating.toString(), size: 20, color: black, fontWeight: FontWeight.w600,),
                                                          Padding(
                                                            padding: const EdgeInsets.only(bottom: 8.0),
                                                            child: Icon(Icons.star, color: theme, size: 14),
                                                          ),
                                                        ]
                                                    )
                                                  ],
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
                                                child: ReturnText(text: '"' + widget.parentBarbersProvider.barbers[index].description.toString() + '"', size: 10, color: black),
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



