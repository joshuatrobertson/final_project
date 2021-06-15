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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();



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
                        padding: EdgeInsets.fromLTRB(20, 100, 20, 0),
                        child: Image.asset(
                          "assets/images/logo.png",
                        ),
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
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: "Name",
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
                          child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: "Email",
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
                          child: TextField(
                              controller: _passwordController,
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
                                onTap: () async {
                                  if (!await authProvider.signUp(
                                      name: _nameController.text.trim(),
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim()
                                  )) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: ReturnText(text: "Sign Up failed!", color: white,)));
                                  }
                                  else {
                                    navigateToScreen(context, Home());
                                  }
                                },
                                child: Center(
                                  child: ReturnText(text: 'Sign Up', fontWeight: FontWeight.w400, size: 30, color: white,),
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
