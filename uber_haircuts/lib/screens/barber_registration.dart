import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:uber_haircuts/providers/authenticate.dart';
import 'package:uber_haircuts/screens/user_gps.dart';
import 'package:uber_haircuts/utilities/files.dart';
import 'package:uber_haircuts/widgets/navigate.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import '../theme/main_theme.dart';
import 'login.dart';
import 'package:provider/provider.dart';

class BarberRegistration extends StatefulWidget {
  const BarberRegistration({Key key}) : super(key: key);

  @override
  _BarberRegistrationState createState() => _BarberRegistrationState();
}

class _BarberRegistrationState extends State<BarberRegistration> {
  final key = new GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _uploadedImageRef;
  File _imageFile;

  // TODO: add location details for location search

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticateProvider>(context);
    return Scaffold(
        body: ListView(
          children: [
            Column(
                children: [
                  Container(
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
                            child: Image.asset(
                              "assets/images/logo.png", width: 200, height: 200,
                            ),
                          )
                        ],
                      )
                  ),
                  Container(
                      child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                              child: TextField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(15),
                                  ],
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    labelText: "Barber Name",
                                  )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                              child: TextField(
                                  keyboardType: TextInputType.multiline,
                                  minLines: 3,
                                  maxLines: null,
                                  controller: _descriptionController,
                                  decoration: InputDecoration(
                                    labelText: "Description",
                                  )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                              child: GestureDetector(
                                onTap: () async {
                                    _imageFile = await getImage();
                                    uploadImage(_imageFile, 'barber_shops').then((value) =>
                                    _uploadedImageRef = value);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    child: ReturnText(text: "Upload an image", color: white,),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                  child: Text(() {
                                    if (_imageFile != null) {
                                      return ("Image Uploaded");
                                    }
                                    else {
                                      return "";
                                    }
                                  }())
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
                                      if (!await authProvider.parentBarberSignUp(
                                          name: _nameController.text.trim(),
                                          email: _emailController.text.trim(),
                                          description: _descriptionController.text.trim(),
                                          password: _passwordController.text.trim(),
                                          image: _uploadedImageRef.trim(),
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
                              padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
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
                ]),
          ],
        )
    );
  }

}
