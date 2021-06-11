import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:uber_haircuts/helpers/navigate.dart';
import 'package:uber_haircuts/providers/authenticate.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import '../common_items.dart';
import 'home.dart';
import 'login.dart';
import 'package:provider/provider.dart';

class Registration extends StatefulWidget {
  const Registration({Key key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final key = new GlobalKey<FormState>();

  String name, email, password;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            children: [
              Container(
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 100, 20, 0),
                        child: ReturnText(text: "INSERT LOGO HERE", size: 30),
                      )
                    ],
                  )
              ),
              Container(
                  child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
                          child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: "Name",
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
                          child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: "Email",
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
                          child: TextField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                labelText: "Password",
                              )
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(35, 40, 35, 0),
                          child: SizedBox(
                            height: 70,
                            child: Material(
                              borderRadius: BorderRadius.circular(15),
                              shadowColor: theme,
                              color: theme,
                              child: GestureDetector(
                                onTap: () {
                                  context.read<Authenticate>().signUp(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                  );
                                  navigateToScreen(context, Home());
                                },
                                child: Center(
                                  child: ReturnText(text: 'Sign Up', fontWeight: FontWeight.w500, size: 30, color: white,),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ReturnText(text: "Already have an account?   "),
                              GestureDetector(
                                  onTap: () {navigateToScreen(context, Login());},
                                  child: ReturnText(text: "Login", color: Colors.red, decoration: TextDecoration.underline,)),
                            ],
                          ),
                        )
                      ])
              ),
            ])
    );
  }
}
