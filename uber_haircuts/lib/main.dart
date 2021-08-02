import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_haircuts/providers/authenticate.dart';
import 'package:uber_haircuts/providers/parent_barbers.dart';
import 'package:uber_haircuts/screens/barber_home.dart';
import 'package:uber_haircuts/screens/barber_login.dart';
import 'package:uber_haircuts/screens/login.dart';
import 'package:uber_haircuts/screens/user_gps.dart';
import 'package:uber_haircuts/screens/user_type.dart';
import 'package:uber_haircuts/widgets/nav_bar.dart';

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
        ListenableProvider<Authenticate>(
          create: (_) => Authenticate(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<Authenticate>().stateChanges, initialData: null,
        ),
        ListenableProvider<ParentBarbersProvider>(
          create: (_) => ParentBarbersProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Chop Chop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
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
    final status = Provider.of<Authenticate>(context);
    final user = context.watch<Authenticate>();


    if (status.authStatus == AuthStatus.UNINITIALISED) {
      return UserType();
    }
    if (status.authStatus == AuthStatus.UNAUTHORISED_BARBER) {
      return BarberLogin();
    }
    if (status.authStatus == AuthStatus.UNAUTHORISED_USER) {
      return Login();
    }
    // If the user is logged in with their GPS taken then show the home screen
    else if (user != null && status.authStatus == AuthStatus.AUTHENTICATED) {
      return UserGPS();
    }
    else if (user != null && status.authStatus == AuthStatus.BARBER_AUTHENTICATED) {
      return BarberHome();
    }
    else if (user != null && status.authStatus == AuthStatus.AUTH_WITH_MAPS) {
      return NavBar();
    }
    // Else they must login
    else {
      return UserType();
    }
  }
}

