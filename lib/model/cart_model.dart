import 'package:khushi_creation/model/cloth_item_model.dart';

class CartItem {
  final ClothItemModel clothes;
  int quantity;

  CartItem({required this.clothes, this.quantity = 1});
}

List<CartItem> cartItems = [];
