import 'package:cloud_firestore/cloud_firestore.dart';

class PromoCodeUtility {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const DISCOUNT_CODE = "discountCodes";


  Future<bool> checkPromoCodeValid(String promoCode) async {
    final DocumentSnapshot snapshot = await _firestore.collection(DISCOUNT_CODE).doc(promoCode).get();
    
    if (snapshot.exists && snapshot.get('active') == true) {
      return true;
    }
    return false;
  }

  Future<num> getDiscount(String promoCode) async {
    final DocumentSnapshot snapshot = await _firestore.collection(DISCOUNT_CODE).doc(promoCode).get();

    return snapshot.get('discount');
  }
}
