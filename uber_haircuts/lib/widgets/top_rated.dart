import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_haircuts/providers/parent_barbers.dart';
import 'package:uber_haircuts/screens/barber_details.dart';
import 'package:uber_haircuts/widgets/navigate.dart';
import 'package:uber_haircuts/widgets/return_image.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import '../theme/main_theme.dart';

class TopRated extends StatelessWidget {
  const TopRated({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _topRatedParentBarbers = Provider.of<ParentBarbersProvider>(context);

    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _topRatedParentBarbers.topRatedParents.length,
        itemBuilder: (_, index){
          return GestureDetector(
            onTap: () {
              navigateToScreen(_, BarberDetails(parentBarberModel: _topRatedParentBarbers.topRatedParents[index], parentBarbersProvider: _topRatedParentBarbers));
            },
            child: Container(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              width: 180,
              child: Stack(
                children:[
                  Container(
                      alignment: Alignment.center,
                      child: ReturnImage(image: _topRatedParentBarbers.topRatedParents[index].image, width: 200, height: 120, boxFit: BoxFit.cover)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Container(

                      alignment: Alignment.bottomCenter,
                      child: ReturnText(text: _topRatedParentBarbers.topRatedParents[index].name, size: 15, color: white,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 6),
                    child: Row(
                      children: [
                        ReturnText(text: _topRatedParentBarbers.topRatedParents[index].rating.toString(), size: 24, color: white, fontWeight: FontWeight.w600,),
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
