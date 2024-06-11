import 'package:flutter/material.dart';
import 'package:khushi_creation/model/cart_item_model.dart';

import 'cloth_item_model.dart';

class ProductDetailsModel {
  ClothItemModel clothes;
  final List<String> imagePaths;
  List<CartItems> cartItems;
  bool isFavorite;
  Function(bool) onFavoriteToggle;
  int selectedImageIndex;

  ProductDetailsModel({
    required this.clothes,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.imagePaths,
    required this.selectedImageIndex,
    List<CartItems>? cartItems,
  }) : cartItems = cartItems ?? [];
}

ClothItemModel product1ClothItemModel = ClothItemModel(
  id: 1,
  style: "Men's Style",
  imagePath: 'assets/images/man/man1.jpg',
  name: 'T-Shirt',
  icon: Icon(
    Icons.star,
    color: Colors.amber,
  ),
  rating: 4.5,
  price: 250.99,
  categories: ['Newest', 'Man'],
  wishListCategories: ['T-Shirt'],
  isFavourite: false,
);

ClothItemModel product2ClothItemModel = ClothItemModel(
  id: 2,
  style: "Women's Style",
  imagePath: 'assets/images/woman/woman1.jpg',
  name: 'Dress',
  icon: Icon(
    Icons.star,
    color: Colors.amber,
  ),
  rating: 4.5,
  price: 450.99,
  categories: ['Popular', 'Woman'],
  wishListCategories: ['Dress'],
  isFavourite: false,
);

List<String> product1ImagePaths = [
  'assets/images/man/man1.jpg',
  'assets/images/man/man2.jpg',
  'assets/images/man/man3.jpg',
  'assets/images/man/man4.jpg',
  'assets/images/man/man5.jpg',
];

List<String> product2ImagePaths = [
  'assets/images/woman/woman1.jpg',
  'assets/images/woman/woman2.jpg',
  'assets/images/woman/woman3.jpg',
  'assets/images/woman/woman4.jpg',
  'assets/images/woman/woman5.jpg',
];

List<String> product3ImagePaths = [
  'assets/images/man/man1.jpg',
  'assets/images/man/man2.jpg',
  'assets/images/man/man3.jpg',
  'assets/images/man/man4.jpg',
  'assets/images/man/man5.jpg',
];

List<String> product4ImagePaths = [
  'assets/images/woman/woman1.jpg',
  'assets/images/woman/woman2.jpg',
  'assets/images/woman/woman3.jpg',
  'assets/images/woman/woman4.jpg',
  'assets/images/woman/woman5.jpg',
];

List<String> product5ImagePaths = [
  'assets/images/man/man1.jpg',
  'assets/images/man/man2.jpg',
  'assets/images/man/man3.jpg',
  'assets/images/man/man4.jpg',
  'assets/images/man/man5.jpg',
];

List<String> product6ImagePaths = [
  'assets/images/woman/woman1.jpg',
  'assets/images/woman/woman2.jpg',
  'assets/images/woman/woman3.jpg',
  'assets/images/woman/woman4.jpg',
  'assets/images/woman/woman5.jpg',
];


List<String> product7ImagePaths = [
  'assets/images/man/man1.jpg',
  'assets/images/man/man2.jpg',
  'assets/images/man/man3.jpg',
  'assets/images/man/man4.jpg',
  'assets/images/man/man5.jpg',
];

List<String> product8ImagePaths = [
  'assets/images/woman/woman1.jpg',
  'assets/images/woman/woman2.jpg',
  'assets/images/woman/woman3.jpg',
  'assets/images/woman/woman4.jpg',
  'assets/images/woman/woman5.jpg',
];


List<String> product9ImagePaths = [
  'assets/images/man/man1.jpg',
  'assets/images/man/man2.jpg',
  'assets/images/man/man3.jpg',
  'assets/images/man/man4.jpg',
  'assets/images/man/man5.jpg',
];

List<String> product10ImagePaths = [
  'assets/images/woman/woman1.jpg',
  'assets/images/woman/woman2.jpg',
  'assets/images/woman/woman3.jpg',
  'assets/images/woman/woman4.jpg',
  'assets/images/woman/woman5.jpg',
];


ProductDetailsModel product1DetailsModel = ProductDetailsModel(
  clothes: product1ClothItemModel,
  isFavorite: false,
  onFavoriteToggle: (isFavorite) {},
  imagePaths: product1ImagePaths,
  selectedImageIndex: 01,
);

ProductDetailsModel product2DetailsModel = ProductDetailsModel(
  clothes: product2ClothItemModel,
  isFavorite: false,
  onFavoriteToggle: (isFavorite) {},
  imagePaths: product2ImagePaths,
  selectedImageIndex: 02,
);
ProductDetailsModel product3DetailsModel = ProductDetailsModel(
  clothes: product1ClothItemModel,
  isFavorite: false,
  onFavoriteToggle: (isFavorite) {},
  imagePaths: product1ImagePaths,
  selectedImageIndex: 03,
);

ProductDetailsModel product4DetailsModel = ProductDetailsModel(
  clothes: product2ClothItemModel,
  isFavorite: false,
  onFavoriteToggle: (isFavorite) {},
  imagePaths: product2ImagePaths,
  selectedImageIndex: 04,
);

ProductDetailsModel product5DetailsModel = ProductDetailsModel(
  clothes: product1ClothItemModel,
  isFavorite: false,
  onFavoriteToggle: (isFavorite) {},
  imagePaths: product1ImagePaths,
  selectedImageIndex: 05,
);

ProductDetailsModel product6DetailsModel = ProductDetailsModel(
  clothes: product2ClothItemModel,
  isFavorite: false,
  onFavoriteToggle: (isFavorite) {},
  imagePaths: product2ImagePaths,
  selectedImageIndex: 06,
);

ProductDetailsModel product7DetailsModel = ProductDetailsModel(
  clothes: product1ClothItemModel,
  isFavorite: false,
  onFavoriteToggle: (isFavorite) {},
  imagePaths: product1ImagePaths,
  selectedImageIndex: 07,
);

ProductDetailsModel product8DetailsModel = ProductDetailsModel(
  clothes: product2ClothItemModel,
  isFavorite: false,
  onFavoriteToggle: (isFavorite) {},
  imagePaths: product2ImagePaths,
  selectedImageIndex: 08,
);

ProductDetailsModel product9DetailsModel = ProductDetailsModel(
  clothes: product1ClothItemModel,
  isFavorite: false,
  onFavoriteToggle: (isFavorite) {},
  imagePaths: product1ImagePaths,
  selectedImageIndex: 09,
);

ProductDetailsModel product10DetailsModel = ProductDetailsModel(
  clothes: product2ClothItemModel,
  isFavorite: false,
  onFavoriteToggle: (isFavorite) {},
  imagePaths: product2ImagePaths,
  selectedImageIndex: 10,
);

