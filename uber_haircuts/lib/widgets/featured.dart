import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_haircuts/providers/parent_barbers.dart';
import 'package:uber_haircuts/screens/barber_details.dart';
import 'package:uber_haircuts/widgets/navigate.dart';
import 'package:uber_haircuts/widgets/return_image.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import '../theme/main_theme.dart';

class Featured extends StatelessWidget {
  const Featured({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _featuredParentBarbers = Provider.of<ParentBarbersProvider>(context);

    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _featuredParentBarbers.featuredParents.length,
        itemBuilder: (_, index){
          return GestureDetector(
            onTap: () {
              // Remove all the barbers that do not belong to the currently indexed parent barber
              navigateToScreen(_, BarberDetails(parentBarbersProvider: _featuredParentBarbers, parentBarberModel: _featuredParentBarbers.featuredParents[index]));
            },
            child: Container(
              padding: const EdgeInsets.only(left: 4.0, right: 4.0),
              height: 200,
              width: 200,
              child: Stack(
                children:[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Container(
                        alignment: Alignment.center,
                        child: ReturnImage(image: _featuredParentBarbers.featuredParents[index].image, width: 200, height: 140, boxFit: BoxFit.cover)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35.0),
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: ReturnText(text: _featuredParentBarbers.featuredParents[index].name, size: 15, color: white,),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
