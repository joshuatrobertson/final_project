import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_haircuts/helpers/navigate.dart';
import 'package:uber_haircuts/models/barber.dart';
import 'package:uber_haircuts/screens/product_details.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import '../common_items.dart';


class AvailableNow extends StatelessWidget {
  const AvailableNow({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<BarberModel> _barbersAvailableNow;

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
                        navigateToScreen(_, ProductDetails(product: _barbersAvailableNow[index].barberProducts[0]));
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
                                  child: Image.asset("assets/images/${_barbers[index].image}.jpg", height: 100, width: 150,)
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
                                    ReturnText(text: _barbers[index].name, size: 15, fontWeight: FontWeight.bold, align: TextAlign.left,),

                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children : [

                                          ReturnText(text: _barbers[index].parentBarber, color: Colors.black54, size: 10),
                                          ReturnText(text: "£" + _barbers[index].barberProducts[0].price.toString(), size: 14, color: accent_1,),
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
