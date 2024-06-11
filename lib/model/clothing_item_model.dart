class ClothingItemModel {
  final String svgPath;
  final String name;

  ClothingItemModel({required this.svgPath, required this.name});
}

final List<ClothingItemModel> clothingItemsModel = [
  ClothingItemModel(svgPath: 'assets/svg/t-shirt.svg', name: 'T-Shirt'),
  ClothingItemModel(svgPath: 'assets/svg/pants.svg', name: 'Pants'),
  ClothingItemModel(svgPath: 'assets/svg/dress-3.svg', name: 'Dress'),
  ClothingItemModel(svgPath: 'assets/svg/winter-jacket.svg', name: 'Jacket'),
];
