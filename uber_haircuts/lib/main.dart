import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_haircuts/providers/authenticate.dart';
import 'package:uber_haircuts/screens/home.dart';
import 'package:uber_haircuts/screens/login.dart';

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

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    if(user != null) {
      return Home();
    }
    else {
      return Login();
    }
    return Container();
  }
}

