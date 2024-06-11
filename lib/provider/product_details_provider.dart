import 'package:khushi_creation/model/cloth_item_model.dart';
import 'package:flutter/material.dart';

class ProductDetailsProvider with ChangeNotifier {
  ClothSize _selectedSize = ClothSize.values.first;
  EnumColor _selectedColor = EnumColor.values.first;

  ClothSize? get selectedSize => _selectedSize;
  EnumColor? get selectedColor => _selectedColor;

  void setSelectedSize(ClothSize size) {
    _selectedSize = size;
    notifyListeners();
  }

  void setSelectedColor(EnumColor color) {
    _selectedColor = color;
    notifyListeners();
  }
}
