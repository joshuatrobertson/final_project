// Class representing a cart item to be used for the shopping cart

class CartItem {
  static const ID = "id";
  static const PRODUCT_ID = "productID";
  static const QUANTITY = "quantity";

  String _id;
  String _productId;
  int _quantity;


  // Get a map from data
  CartItem.fromMap(Map item){
    _id = item[ID];
    _productId =  item[PRODUCT_ID];
    _quantity =  item[QUANTITY];
  }

  // Create a map with json objects
  Map toMap() => {
    ID: _id,
    PRODUCT_ID: _productId,
    QUANTITY: _quantity,
    };
  }

