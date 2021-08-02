import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uber_haircuts/providers/authenticate.dart';
import 'package:uber_haircuts/screens/barber_login.dart';
import 'package:uber_haircuts/theme/main_theme.dart';
import 'package:uber_haircuts/widgets/navigate.dart';
import 'package:uber_haircuts/widgets/return_text.dart';

import 'login.dart';

class UserType extends StatefulWidget {

  @override
  _UserTypeState createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<Authenticate>(context);

    return Scaffold(
        body: Column(
            children: [
              Container(
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 50, 20, 10),
                        child: Image.asset(
                          "assets/images/logo.png", width: 200, height: 200,
                        ),
                      )
                    ],
                  )
              ),
              Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                        children: [
                          ReturnText(text: "I am a", size: 30,),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(35, 10, 35, 0),
                            child: SizedBox(
                              height: 70,
                              child: Material(
                                borderRadius: BorderRadius.circular(15),
                                shadowColor: theme,
                                color: theme,
                                child: GestureDetector(
                                  onTap: () async {
                                    authProvider.chooseUser('user');
                                  },
                                  child: Center(
                                    child: ReturnText(text: 'Customer', fontWeight: FontWeight.w400, size: 30, color: white,),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  )
              ),
              Container(
                  child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(35, 40, 35, 0),
                          child: SizedBox(
                            height: 70,
                            child: Material(
                              borderRadius: BorderRadius.circular(15),
                              shadowColor: theme,
                              color: theme,
                              child: GestureDetector(
                                onTap: () async {
                                  authProvider.chooseUser('barber');
                                },
                                child: Center(
                                  child: ReturnText(text: 'Barber', fontWeight: FontWeight.w400, size: 30, color: white,),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ])
              ),
            ])
    );
  }
}
