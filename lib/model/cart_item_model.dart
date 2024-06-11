class CartItems {
  final String imagePath;
  final String name;
  final String size;
  final double price;
  int quantity;

  CartItems({
    required this.imagePath,
    required this.name,
    required this.size,
    required this.price,
    this.quantity = 1,
  });
}