import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_haircuts/models/barber.dart';
import 'package:uber_haircuts/models/product.dart';
import 'package:uber_haircuts/providers/parent_barbers.dart';
import 'package:uber_haircuts/screens/product_details.dart';
import 'package:uber_haircuts/widgets/navigate.dart';
import 'package:uber_haircuts/widgets/return_image.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import '../theme/main_theme.dart';
import 'cart.dart';

class ProductList extends StatefulWidget {
  final ParentBarbersProvider parentBarbersProvider;
  final BarberModel barberModel;

  createState() => _ProductList();

  ProductList({@required this.parentBarbersProvider, @required this.barberModel});

}

class _ProductList extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    List<ProductModel> _products = widget.parentBarbersProvider.products.where((product) =>
    product.barberID == widget.barberModel.id).toList();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: lightGrey,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined, color: theme,),
            onPressed: () {Navigator.pop(context);},
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_basket, color: theme,),
              onPressed: () {
                navigateToScreen(context, Cart());
              },
            )
          ],
        ),
        body: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _products.length,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                navigateToScreen(
                                    _, ProductDetails(product: _products[index])
                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: lightGrey,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(6.0)
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 8,
                                      blurRadius: 8,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8.0, 8.0, 8.0, 0),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(6.0),
                                          child: ReturnImage(image: _products[index].image, width: 150, height: 100)
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
                                            ReturnText(text: _products[index].name,
                                              size: 15,
                                              fontWeight: FontWeight.bold,
                                              align: TextAlign.left,),

                                            Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [

                                                  ReturnText(
                                                      text: _products[index].name,
                                                      color: Colors.black54,
                                                      size: 10),
                                                  ReturnText(text: "£" +
                                                      _products[index].price.toString(),
                                                    size: 14,
                                                    color: Colors.redAccent,),
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
                        }),
                    ),
            ]),
          ),
        ),
      ),
    ));
  }
}



