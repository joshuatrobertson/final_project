import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:uber_haircuts/helpers/navigate.dart';
import 'package:uber_haircuts/providers/authenticate.dart';
import 'package:uber_haircuts/screens/registration.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import '../common_items.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final key = new GlobalKey<FormState>();
  String email, password;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


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
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
                  child: Container(
                    alignment: Alignment.topRight,
                    child:
                    ReturnText(text: "Forgot Password?", color: Colors.red, decoration: TextDecoration.underline,),
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
                          context.read<Authenticate>().signIn(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim()
                          );
                        },
                        child: Center(
                          child: ReturnText(text: 'Login', fontWeight: FontWeight.w400, size: 30, color: white,),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(70.0, 20, 70, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (context.read<Authenticate>().googleSignIn() == true) {

                          }
                        },
                        child: Image.asset(
                          "assets/images/google.png",
                          height: 40,
                          width: 40,),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<Authenticate>().facebookSignIn();
                        },
                        child: Image.asset(
                          "assets/images/facebook.png",
                          height: 65,
                          width: 65,),
                      ),
                      GestureDetector(
                        onTap: () {

                        },
                        child: Image.asset(
                          "assets/images/twitter.jpeg",
                          height: 40,
                          width: 40,),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ReturnText(text: "Don't have an account?   "),
                      GestureDetector(
                        onTap: () {navigateToScreen(context, Registration());},
                          child: ReturnText(text: "Sign Up", color: Colors.red, decoration: TextDecoration.underline,)),
                    ],
                  ),
                )
                ])
            ),
          ])
      );
  }
}
