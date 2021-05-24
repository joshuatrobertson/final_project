import 'package:flutter/material.dart';

import 'models/barber.dart';
import 'models/parent_barber.dart';
import 'models/prices.dart';
import 'models/product.dart';

// Used to keep track of global variables, such as different theme colours
const Color main = Color(0xFFFE5E7D);
const Color pink1 = Color(0xFFFAACBA);
const Color pink2 = Color(0xFFFAABB9);
const Color lightGrey = Color(0xFFF5F5F5);
const Color white = Colors.white;
const Color black = Colors.black;
const Color grey = Colors.grey;

List<ParentBarber> featuredParentBarbers = [
  ParentBarber(name: "Downtown Barbers", image: "barber03", rating: 4.6, barbers: barbers),
  ParentBarber(name: "High Street Barbers", image: "barber04", rating: 4.9, barbers: barbers2),
];

List<ParentBarber> topRatedParentBarbers = [
  ParentBarber(name: "Downtown Barbers", image: "barber03", rating: 4.6, barbers: barbers),
  ParentBarber(name: "High Street Barbers", image: "barber04", rating: 4.9, barbers: barbers2),
  ParentBarber(name: "Johns Cut", image: "barber05", rating: 4.9, barbers: barbers3),
];



List<Product> products = [
  Product(0, "Haircut", "A simple haircut", false),
  Product(1, "Shave", "A simple shave", false),
  Product(2, "Student Cut", "A discounted student cut", false),
];

List<Prices> productsJohn = [
  Prices(0, 10.50, products[0], true),
];

List<Prices> productsPaul = [
  Prices(0, 10.20, products[0], true),
];

List<Prices> productsSarah = [
  Prices(0, 8.90, products[0], true),
];

List<Prices> productsEmily = [
  Prices(0, 14.20, products[0], true),
];

List<Barber> barbers = [
  Barber(0, "John", "barber01", "A 22 year old with 2 years experience", "Downtown Barbers", 4.9, true, true, productsJohn),
  Barber(1, "Paul", "barber02", "A 33 year old with 10 years experience", "Downtown Barbers", 4.6, true, false, productsJohn),
  Barber(2, "Sarah", "barber03", "A 33 year old with 10 years experience", "Downtown Barbers", 4.2, true, false, productsSarah),
  Barber(3, "Emily", "barber04", "A 33 year old with 10 years experience", "Downtown Barbers", 4.6, true, false, productsEmily),
];

List<Barber> barbers2 = [
  Barber(0, "Peter", "barber01", "A 22 year old with 2 years experience", "High Street Barbers", 4.9, true, true, productsJohn),
  Barber(1, "Jason", "barber02", "A 33 year old with 10 years experience", "High Street Barbers", 4.6, true, false, productsJohn),
  Barber(2, "Gemima", "barber03", "A 33 year old with 10 years experience", "High Street Barbers", 4.2, true, false, productsSarah),
  Barber(3, "Duncan", "barber04", "A 33 year old with 10 years experience", "High Street Barbers", 4.6, true, false, productsEmily),
];

List<Barber> barbers3 = [
  Barber(0, "Elena", "barber01", "A 22 year old with 2 years experience", "Johns Cut", 4.9, true, true, productsJohn),
  Barber(1, "Jeremy", "barber02", "A 33 year old with 10 years experience", "Johns Cut", 4.6, true, false, productsJohn),
  Barber(2, "Mitch", "barber03", "A 33 year old with 10 years experience", "Johns Cut", 4.2, true, false, productsSarah),
  Barber(3, "Saara", "barber04", "A 33 year old with 10 years experience", "Johns Cut", 4.6, true, false, productsEmily),
];
