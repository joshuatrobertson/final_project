import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_haircuts/models/parent_barber.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import '../common_items.dart';

List<ParentBarber> featuredParentsBarbers = [
  ParentBarber(name: "Downtown Barbers", image: "barber05", rating: 4.6),
  ParentBarber(name: "High Street Barbers", image: "barber06", rating: 4.9),
  ParentBarber(name: "Johns Cut", image: "barber07", rating: 4.7),
  ParentBarber(name: "No.5 Hairdressers", image: "barber08", rating: 4.9)
];


class TopRated extends StatelessWidget {
  const TopRated({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: featuredParentsBarbers.length,
        itemBuilder: (_, index){
          return Container(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            height: 120,
            width: 190,
            child: Stack(
              children:[
                Container(
                    alignment: Alignment.center,
                    child: Image.asset("assets/images/${featuredParentsBarbers[index].image}.jpg", height: 120, width: 200,
                      fit: BoxFit.cover,
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Container(

                    alignment: Alignment.bottomCenter,
                    child: ReturnText(text: featuredParentsBarbers[index].name, size: 15, color: white,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 45.0, left: 6),
                  child: Row(
                    children: [
                      ReturnText(text: featuredParentsBarbers[index].rating.toString(), size: 17, color: white, fontWeight: FontWeight.w600,),
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
        });
  }
}
