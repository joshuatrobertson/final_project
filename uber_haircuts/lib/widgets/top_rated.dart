import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_haircuts/models/parent_barber.dart';
import 'package:uber_haircuts/providers/parent_barbers.dart';
import 'package:uber_haircuts/screens/barber_details.dart';
import 'package:uber_haircuts/widgets/filter_list.dart';
import 'package:uber_haircuts/widgets/navigate.dart';
import 'package:uber_haircuts/widgets/return_image.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import '../theme/main_theme.dart';

class TopRated extends StatelessWidget {

  final FilterList _filterList = new FilterList();

  @override
  Widget build(BuildContext context) {

    final _parentsBarbers = Provider.of<ParentBarbersProvider>(context);

    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _parentsBarbers..length,
        itemBuilder: (_, index){
          return GestureDetector(
            onTap: () {
              navigateToScreen(_, BarberDetails(parentBarberModel: _topRatedParents[index], parentBarbersProvider: _parentsBarbers));
            },
            child: Container(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              width: 180,
              child: Stack(
                children:[
                  Container(
                      alignment: Alignment.center,
                      child: ReturnImage(image: _topRatedParents[index].image, width: 200, height: 120, boxFit: BoxFit.cover)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Container(

                      alignment: Alignment.bottomCenter,
                      child: ReturnText(text: _topRatedParents[index].name, size: 15, color: white,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 6),
                    child: Row(
                      children: [
                        ReturnText(text: _topRatedParents[index].rating.toString(), size: 24, color: white, fontWeight: FontWeight.w600,),
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
