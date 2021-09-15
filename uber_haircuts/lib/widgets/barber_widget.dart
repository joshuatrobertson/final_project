import 'package:uber_haircuts/models/product.dart';

ProductModel createNewProduct(Map items) {
  ProductModel productModel = new ProductModel();
  productModel = ProductModel.fromMap(items);
  return productModel;
}

