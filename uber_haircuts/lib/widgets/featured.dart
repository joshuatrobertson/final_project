import 'package:flutter/cupertino.dart';

class Featured extends StatelessWidget {
  const Featured({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (_, index){
          return Container(
            height: 200,
            width: 200,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Image.asset("assets/images/barber01.jpg", height: 200, width: 200,),
                )
              ],
            ),
          );
        });
  }
}
