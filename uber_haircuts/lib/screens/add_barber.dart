import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uber_haircuts/providers/authenticate.dart';
import 'package:uber_haircuts/screens/user_gps.dart';
import 'package:uber_haircuts/utilities/barber_firestore.dart';
import 'package:uber_haircuts/utilities/files.dart';
import 'package:uber_haircuts/widgets/navigate.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import '../theme/main_theme.dart';
import 'login.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

class AddBarber extends StatefulWidget {
  const AddBarber({Key key}) : super(key: key);

  @override
  _AddBarberState createState() => _AddBarberState();
}

class _AddBarberState extends State<AddBarber> {
  final key = new GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _uploadedImageRef;
  final _imagePicker = ImagePicker();
  File _imageFile;
  final BarberFirestore _barberFirestore = new BarberFirestore();



  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Authenticate>(context);
    return Scaffold(
        body: ListView(
          children: [
            Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back_ios_outlined, color: theme,),
                              onPressed: () {Navigator.pop(context);},),
                          ],
                        ),
                      )
                    ],
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
                                  controller: _firstNameController,
                                  decoration: InputDecoration(
                                    labelText: "First Name",
                                  )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                              child: TextField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(15),
                                  ],
                                  controller: _lastNameController,
                                  decoration: InputDecoration(
                                    labelText: "Last Name",
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
                                  _uploadedImageRef = await uploadImage(_imageFile, 'barbers');
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
                                      if (!await _barberFirestore.createAddBarber(
                                        firstName: _firstNameController.text.trim(),
                                        lastName: _lastNameController.text.trim(),
                                        description: _descriptionController.text.trim(),
                                        image: _uploadedImageRef.trim(),
                                      )) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                                content: ReturnText(text: "Adding new barber failed!", color: white,)));
                                      }
                                      else {
                                        navigateToScreen(context, UserGPS());
                                      }
                                    },
                                    child: Center(
                                      child: ReturnText(text: 'Add Barber', fontWeight: FontWeight.w400, size: 30, color: white,),
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
