import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_haircuts/helpers/navigate.dart';
import 'package:uber_haircuts/models/parent_barber.dart';
import 'package:uber_haircuts/screens/barber_details.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import '../common_items.dart';

class Featured extends StatelessWidget {
  const Featured({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: featuredParentBarbers.length,
        itemBuilder: (_, index){
          return GestureDetector(
            onTap: () {
              navigateToScreen(_, BarberDetails(parentBarber: featuredParentBarbers[index]));
            },
            child: Container(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              height: 200,
              width: 200,
              child: Stack(
                children:[
                  Container(
                      alignment: Alignment.center,
                      child: Image.asset("assets/images/${featuredParentBarbers[index].image}.jpg", height: 140, width: 200,
                        fit: BoxFit.cover,
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35.0),
                    child: Container(

                      alignment: Alignment.bottomCenter,
                      child: ReturnText(text: featuredParentBarbers[index].name, size: 15, color: white,),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
