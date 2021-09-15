import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uber_haircuts/providers/authenticate.dart';
import 'package:uber_haircuts/screens/barber_login.dart';
import 'package:uber_haircuts/screens/registration.dart';
import 'package:uber_haircuts/screens/user_type.dart';
import 'package:uber_haircuts/widgets/navigate.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import '../theme/main_theme.dart';
import 'add_barber.dart';
import 'change_address.dart';
import 'barber_registration.dart';
import 'delete_barber.dart';
import 'forgot_password.dart';

class BarberHome extends StatefulWidget {
  const BarberHome({Key key}) : super(key: key);

  @override
  _BarberHomeState createState() => _BarberHomeState();
}

class _BarberHomeState extends State<BarberHome> {



  @override
  Widget build(BuildContext context) {
    // Allows use of provider package throughout app
    final authProvider = Provider.of<AuthenticateProvider>(context);


    return Scaffold(
      // Shows loading wheel before user is logged in
        body: authProvider.authStatus == AuthStatus.AUTHENTICATING ? Center(child: CircularProgressIndicator(),) : Column(
            children: [
              Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(35, 60, 35, 0),
                        child: SizedBox(
                          height: 70,
                          child: Material(
                            borderRadius: BorderRadius.circular(15),
                            color: theme,
                            child: GestureDetector(
                              onTap: () async {
                                navigateToScreen(context, AddBarber());
                              },
                              child: Center(
                                child: ReturnText(text: 'Add Barber', fontWeight: FontWeight.w400, size: 30, color: white,),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(35, 60, 35, 0),
                        child: SizedBox(
                          height: 70,
                          child: Material(
                            borderRadius: BorderRadius.circular(15),
                            color: theme,
                            child: GestureDetector(
                              onTap: () async {
                                /*
                                navigateToScreen(context, DeleteBarber());

                                 */
                              },
                              child: Center(
                                child: ReturnText(text: 'Delete Barber', fontWeight: FontWeight.w400, size: 30, color: white,),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(35, 60, 35, 0),
                        child: SizedBox(
                          height: 70,
                          child: Material(
                            borderRadius: BorderRadius.circular(15),
                            color: theme,
                            child: GestureDetector(
                              onTap: () async {
                              },
                              child: Center(
                                child: ReturnText(text: 'View Orders', fontWeight: FontWeight.w400, size: 30, color: white,),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(35, 60, 35, 0),
                        child: SizedBox(
                          height: 70,
                          child: Material(
                            borderRadius: BorderRadius.circular(15),
                            color: theme,
                            child: GestureDetector(
                              onTap: () async {
                                authProvider.signOut('barber');
                                clearNavigator(context);
                              },
                              child: Center(
                                child: ReturnText(text: 'Sign Out', fontWeight: FontWeight.w400, size: 30, color: white,),
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
