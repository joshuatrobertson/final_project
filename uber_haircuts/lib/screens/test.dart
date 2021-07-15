import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_haircuts/models/parent_barber.dart';
import 'package:uber_haircuts/utilities/distance_query.dart';
import 'package:uber_haircuts/widgets/return_text.dart';

class TestScreen extends StatefulWidget {

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  DistanceQuery _distanceQuery = DistanceQuery();
  var items;
  List<ParentBarberModel> parentBarbers = [];

  @override
  Widget build(BuildContext context) {
    Stream<List<DocumentSnapshot>> stream = _distanceQuery.getLocalItems();
    stream.listen((List<DocumentSnapshot> list) {
      for (DocumentSnapshot parent in list) {
        ParentBarberModel barber = ParentBarberModel.fromSnapshot(parent);
        print(barber.name);
        parentBarbers.add(barber);
      }
    });
    print("LIST:!!" + parentBarbers[0].name + parentBarbers[1].name);
    return ReturnText(text: parentBarbers[0].name + parentBarbers[1].name);
  }
}

