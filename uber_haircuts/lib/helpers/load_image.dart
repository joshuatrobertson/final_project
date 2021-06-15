import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class LoadImage extends ChangeNotifier {
  LoadImage();

  FirebaseStorage storage = FirebaseStorage.instance;

  static Future<dynamic> loadFromDatabase(BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}