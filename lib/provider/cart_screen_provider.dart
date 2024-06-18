import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../model/cart_model.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  List<CartItem> get items => _items;

  double get subtotal => _items.fold(
        0,
        (total, item) => total + (item.clothes.price * item.quantity),
      );
  double get discount => subtotal * 0.05;

  double get baseDeliveryFee {
    return subtotal > 2000 ? 0 : 40;
  }

  double _deliveryFee = 0.0;
  double get deliveryFee => _deliveryFee > 0 ? _deliveryFee : baseDeliveryFee;

  void setDeliveryFee(double fee) {
    _deliveryFee = fee;
    notifyListeners();
  }

  double get totalPrice => subtotal + deliveryFee - discount;

  void addItem(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void incrementQuantity(CartItem item) {
    item.quantity++;
    notifyListeners();
  }

  void decrementQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
      notifyListeners();
    }
  }
}
