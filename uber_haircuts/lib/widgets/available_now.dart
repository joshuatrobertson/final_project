import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_haircuts/models/barber.dart';
import 'package:uber_haircuts/providers/parent_barbers.dart';
import 'package:uber_haircuts/screens/product_list.dart';
import 'package:uber_haircuts/widgets/navigate.dart';
import 'package:uber_haircuts/widgets/return_image.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import '../theme/main_theme.dart';


class AvailableNow extends StatelessWidget {
  const AvailableNow({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final _parentBarbers = Provider.of<ParentBarbersProvider>(context);

    List<BarberModel> _barbers = _parentBarbers.barbers.where((barber) =>
    barber.availableNow == true).toList();


    return Container(
      height: 180,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        child: Container(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _barbers.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        navigateToScreen(_, ProductList(parentBarbersProvider: _parentBarbers, barberModel: _barbers[index],
                        ));
                      //product: _barbers[index].barberProducts[0])
                        },
                      child: Container(
                        decoration: BoxDecoration(
                          color: lightGrey,
                          borderRadius: BorderRadius.all(
                              Radius.circular(6.0)
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.35),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget> [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
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
                                    ReturnText(text: _barbers[index].firstName, size: 15, fontWeight: FontWeight.bold, align: TextAlign.left,),

                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children : [

                                          ReturnText(text: _parentBarbers.allParents.where((parentBarber) =>
                                            parentBarber.id == _barbers[index].parentBarberID).toList()[0].name, color: Colors.black54, size: 10),
                                        ]
                                    )
                                  ],
                                ),
                              ),

                            ),
                          ],
                        ),

                      ),
                    ),
                  );
                })
        ),
      ),
    );
  }
}
