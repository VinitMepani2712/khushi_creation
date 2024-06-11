import 'package:flutter/material.dart';

enum ClothSize { S, M, L, XL, XXL, XXXL }

enum EnumColor { Blue, Brown, Orange, Black }

class ClothItemModel {
  int id;
  String style;
  String imagePath;
  String name;
  Icon icon;
  double rating;
  double price;
  List<String> categories;
  List<String> wishListCategories;
  bool isFavourite;
  ClothSize? selectedSize;
  EnumColor? selectedColor;

  ClothItemModel({
    required this.id,
    required this.style,
    required this.imagePath,
    required this.name,
    required this.icon,
    required this.rating,
    required this.price,
    required this.categories,
    required this.wishListCategories,
    required this.isFavourite,
    this.selectedSize,
    this.selectedColor,
  });
}
