import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_haircuts/helpers/navigate.dart';
import 'package:uber_haircuts/models/parent_barber.dart';
import 'package:uber_haircuts/screens/barber_details.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import '../common_items.dart';


class TopRated extends StatelessWidget {
  const TopRated({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ParentBarberModel> _topRatedBarbers;
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _topRatedBarbers.length,
        itemBuilder: (_, index){
          return GestureDetector(
            onTap: () {
              navigateToScreen(_, BarberDetails(parentBarber: _topRatedBarbers[index]));
            },
            child: Container(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              width: 180,
              child: Stack(
                children:[
                  Container(
                      alignment: Alignment.center,
                      child: Image.asset("assets/images/${_topRatedBarbers[index].image}.jpg", height: 120, width: 200,
                        fit: BoxFit.cover,
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Container(

                      alignment: Alignment.bottomCenter,
                      child: ReturnText(text: _topRatedBarbers[index].name, size: 15, color: white,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 6),
                    child: Row(
                      children: [
                        ReturnText(text: _topRatedBarbers[index].rating.toString(), size: 24, color: white, fontWeight: FontWeight.w600,),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Icon(Icons.star, color: white, size: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
