import 'package:khushi_creation/model/product_details_model.dart';
import 'package:khushi_creation/screens/product_details_screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:khushi_creation/model/cloth_item_model.dart';
import 'package:khushi_creation/model/cloth_item_model_content.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FilteredClothesScreen extends StatelessWidget {
  final String wishListCategories;

  FilteredClothesScreen({required this.wishListCategories});

  @override
  Widget build(BuildContext context) {
    final filteredClothes = clothItemModel.where((item) {
      return item.wishListCategories.contains(wishListCategories);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('$wishListCategories Clothes'),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildClothItems(filteredClothes, context),
          ],
        ),
      ),
    );
  }

  Widget buildClothItems(
      List<ClothItemModel> filteredClothes, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        children: filteredClothes.map((cloth) {
          return buildClothItemTile(cloth, context);
        }).toList(),
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
    );
  }

  Widget buildClothItemTile(ClothItemModel cloth, BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(
            productDetailsModel: ProductDetailsModel(
              clothes: cloth,
              onFavoriteToggle: (isFavorite) {},
              isFavorite: false,
              imagePaths: [],
              selectedImageIndex: 0,
            ),
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Image.asset(
                cloth.imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cloth.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      cloth.icon,
                      SizedBox(width: 5),
                      Text(cloth.rating.toString()),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '\u{20B9}${cloth.price}',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
