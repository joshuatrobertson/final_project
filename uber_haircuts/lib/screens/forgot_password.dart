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

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final key = new GlobalKey<FormState>();

  String email;

  final TextEditingController emailController = TextEditingController();



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
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: "Email",
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
                                  context.read<Authenticate>().resetPassword(
                                    emailController.text.trim()
                                  );
                                  navigateToScreen(context, Login());
                                },
                                child: Center(
                                  child: ReturnText(text: 'Send Reset Link', fontWeight: FontWeight.w500, size: 30, color: white,),
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
