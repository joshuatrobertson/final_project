import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_haircuts/models/barber.dart';
import 'package:uber_haircuts/models/prices.dart';
import 'package:uber_haircuts/models/product.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import '../common_items.dart';

List<Product> products = [
  Product(0, "Haircut", "A simple haircut", false),
  Product(1, "Shave", "A simple shave", false),
  Product(2, "Student Cut", "A discounted student cut", false),
];

List<Prices> productsJohn = [
  Prices(0, 10.50, products[0], true),
];

List<Prices> productsPaul = [
  Prices(0, 10.20, products[0], true),
];

List<Prices> productsSarah = [
  Prices(0, 8.90, products[0], true),
];

List<Prices> productsEmily = [
  Prices(0, 14.20, products[0], true),
];

List<Barber> barbers = [
  Barber(0, "John", "barber01", "A 22 year old with 2 years experience", "High Street Barbers", 4.9, true, true, productsJohn),
  Barber(1, "Paul", "barber02", "A 33 year old with 10 years experience", "Downtown Barbers", 4.6, true, false, productsJohn),
  Barber(2, "Sarah", "barber03", "A 33 year old with 10 years experience", "Downtown Barbers", 4.2, true, false, productsSarah),
  Barber(3, "Emily", "barber04", "A 33 year old with 10 years experience", "Downtown Barbers", 4.6, true, false, productsEmily),

];

class AvailableNow extends StatelessWidget {
  const AvailableNow({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        child: Container(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: barbers.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: lightGrey,
                        borderRadius: BorderRadius.all(
                            Radius.circular(6.0)
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 4,
                            blurRadius: 4,
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
                                child: Image.asset("assets/images/${barbers[index].image}.jpg", height: 100, width: 150,)
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
                                  ReturnText(text: barbers[index].name, size: 15, fontWeight: FontWeight.bold, align: TextAlign.left,),

                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children : [

                                        ReturnText(text: barbers[index].parentBarber, color: Colors.black54, size: 10),
                                        ReturnText(text: "£" + barbers[index].barberProducts[0].price.toString(), size: 14, color: Colors.redAccent,),
                                      ]
                                  )
                                ],
                              ),
                            ),

                          ),
                        ],
                      ),

                    ),
                  );
                })
        ),
      ),
    );
  }
}
