import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:uber_haircuts/providers/authenticate.dart';
import 'package:uber_haircuts/screens/user_gps.dart';
import 'package:uber_haircuts/widgets/navigate.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import '../theme/main_theme.dart';
import 'home.dart';
import 'login.dart';
import 'package:provider/provider.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final key = new GlobalKey<FormState>();

  String name, email, password;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthenticateProvider>(context);
    String dropdownValue = 'One';

    return Scaffold(
        body: Column(
            children: [
              Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0,50,0,0),
                    child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: <String>['One', 'Two', 'Free', 'Four']
                                  .map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )),
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
                                      navigateToScreen(context, UserGPS());
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
                        ]),
                  )
              ),
            ])
    );
  }
}
