import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uber_haircuts/providers/authenticate.dart';
import 'package:uber_haircuts/screens/barber_login.dart';
import 'package:uber_haircuts/screens/registration.dart';
import 'package:uber_haircuts/widgets/navigate.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import '../theme/main_theme.dart';
import 'forgot_password.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email, password;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePasswordText = true;
  Color _hidePasswordColour = Colors.grey;


  // TODO: request location from user here and start getting items to pass through to the home page
  @override
  Widget build(BuildContext context) {
    // Allows use of provider package throughout app
    final authProvider = Provider.of<AuthenticateProvider>(context);


    return Scaffold(
      // Shows loading wheel before user is logged in
      body: authProvider.authStatus == AuthStatus.AUTHENTICATING ? Center(child: CircularProgressIndicator(),) : Column(
        children: [
          Container(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
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
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      )
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
                  child: TextField(
                    obscureText: _obscurePasswordText,
                    controller: _passwordController,
                      decoration: InputDecoration(
                          labelText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              // Toggles the icon colour/ obscures text
                              if (_hidePasswordColour == Colors.grey) {
                                _hidePasswordColour = Colors.blueAccent;
                              } else {
                                _hidePasswordColour = Colors.grey;
                              }
                              _obscurePasswordText = !_obscurePasswordText;
                            });
                            },
                          icon: Icon(Icons.remove_red_eye, color: _hidePasswordColour,),
                        )
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
                  child: Container(
                    alignment: Alignment.topRight,
                    child:
                    GestureDetector(
                    onTap: () {
                      navigateToScreen(context, ForgotPassword());
                    },
                    child: ReturnText(text: "Forgot Password?", color: Colors.red, decoration: TextDecoration.underline,)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 40, 35, 0),
                  child: SizedBox(
                    height: 70,
                    child: Material(
                      borderRadius: BorderRadius.circular(15),
                      color: theme,
                      child: GestureDetector(
                        onTap: () async {
                          if (!await authProvider.signIn(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim()
                          )) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: ReturnText(text: "Login failed!", color: white,)));
                          }
                        },
                        child: Center(
                          child: ReturnText(text: 'Login', fontWeight: FontWeight.w400, size: 30, color: white,),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: GestureDetector(
                      onTap: () {
                        navigateToScreen(context, BarberLogin());
                      },
                      child: ReturnText(text: "Sign in as a barber", color: Colors.red, decoration: TextDecoration.underline,)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(70.0, 0, 70, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          authProvider.googleSignIn();
                          },
                        child: Image.asset(
                          "assets/images/google.png",
                          height: 40,
                          width: 40,),
                      ),
                      GestureDetector(
                        onTap: () {
                          authProvider.facebookSignIn();
                        },
                        child: Image.asset(
                          "assets/images/facebook.png",
                          height: 65,
                          width: 65,),
                      ),
                      GestureDetector(
                        onTap: () {
                          authProvider.twitterSignIn('1403651379705663488-I6gxGAkJqPrkSRXTxysm5wmI3Hc5no', 'KVP7xVAAdZYZ5TV1xW5tQBAriXR8QOPvOxqhYc9OWi0L4');
                        },
                        child: Image.asset(
                          "assets/images/twitter.jpeg",
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ReturnText(text: "Don't have an account?   "),
                      GestureDetector(
                        onTap: () {
                          navigateToScreen(context, Registration());
                            },
                          child: ReturnText(text: "Sign Up", color: Colors.red, decoration: TextDecoration.underline,)
                      ),
                    ],
                  ),
                )
                ])
            ),
          ])
      );
  }

}
