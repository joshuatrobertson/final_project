import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_haircuts/providers/authenticate.dart';
import 'package:uber_haircuts/screens/home.dart';
import 'package:uber_haircuts/screens/login.dart';
import 'package:uber_haircuts/screens/user_gps.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Authenticate>(
          create: (context) => Authenticate(FirebaseAuth.instance),
        ),
        StreamProvider(create: (context) => context.read<Authenticate>().stateChanges, initialData: null,)
      ],
      child: MaterialApp(
        title: 'Chop Chop',
        theme: ThemeData(
          primarySwatch: Colors.red,
          fontFamily: 'Poppins'
        ),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

// If the user is not logged in return the login screen
class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use Provider.of to fetch the authentication status and return the appropriate screen
    final auth = Provider.of<Authenticate>(context);
    final user = context.watch<Authenticate>();

    // If the user is logged in with their GPS taken then show the home screen
    if (user != null && auth.authStatus == AuthStatus.AUTHENTICATED) {
      return Home();
    }
    else if (user != null && auth.authStatus == AuthStatus.AUTH_WITH_MAPS) {
      return UserGPS();
    }
    // Else they must login
    else {
      return Login();
    }
  }
}

