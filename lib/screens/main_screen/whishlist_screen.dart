import 'package:khushi_creation/model/cloth_item_model.dart';
import 'package:khushi_creation/model/product_details_model.dart';
import 'package:khushi_creation/screens/product_details_screen/product_details_screen.dart';
import 'package:khushi_creation/provider/homes_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
      ),
      body: Consumer<HomeProviderScreen>(
        builder: (context, homeScreenProvider, child) {
          return Column(
            children: [
              buildCategoryItems(
                  context: context, homeScreenProvider: homeScreenProvider),
              SizedBox(height: 20),
              Expanded(
                child: buildCard(homeScreenProvider),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildCategoryItems({
    required BuildContext context,
    required HomeProviderScreen homeScreenProvider,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 42.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: homeScreenProvider.wishListCategories.length,
            itemBuilder: (context, index) {
              return buildCategorySectionSlider(
                  context, index, homeScreenProvider.wishListCategories[index],
                  homeScreenProvider: homeScreenProvider);
            },
          ),
        ),
      ],
    );
  }

  Widget buildCategorySectionSlider(
      BuildContext context, int index, String categoryName,
      {required HomeProviderScreen homeScreenProvider}) {
    return GestureDetector(
      onTap: () {
        homeScreenProvider.updateWishListCatogryData(index: index);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Container(
          height: 40.h,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: homeScreenProvider.selectedWishListCategoryIndex == index
                ? Color(0xff704F38)
                : Colors.transparent,
            border: homeScreenProvider.selectedWishListCategoryIndex == index
                ? null
                : Border.all(color: Color(0xffD0D5DD)),
          ),
          child: Center(
            child: Text(
              categoryName,
              style: TextStyle(
                color: homeScreenProvider.selectedWishListCategoryIndex == index
                    ? Colors.white
                    : Color.fromARGB(255, 0, 0, 0),
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCard(HomeProviderScreen homeScreenProvider) {
    if (homeScreenProvider.filteredFavoriteClothes.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Text(
            "In this category, you haven't added any items to your favorites yet. \n\nBrowse through and pick your favorites to personalize your collection!",
            style: TextStyle(fontSize: 18.0),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: homeScreenProvider.filteredFavoriteClothes.length,
          itemBuilder: (context, index) {
            final clothes = homeScreenProvider.filteredFavoriteClothes[index];
            return buildClothesCard(clothes, index, homeScreenProvider);
          },
        ),
      );
    }
  }

  Widget buildClothesCard(
      ClothItemModel item, int index, HomeProviderScreen homeScreenProvider) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(
            productDetailsModel: ProductDetailsModel(
                clothes: item,
                onFavoriteToggle: (isFavorite) {},
                isFavorite: true, imagePaths: [], selectedImageIndex: 0), 
          ),
        ),
      ),
      child: Container(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      item.imagePath,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          item.icon,
                          SizedBox(width: 5.w),
                          Text(item.rating.toString()),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '\u{20B9}${item.price}',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 5,
              right: 10,
              child: InkWell(
                onTap: () {
                  homeScreenProvider.updateFavoriteData(id: item.id);
                },
                child: CircleAvatar(
                  maxRadius: 15,
                  minRadius: 15,
                  backgroundColor: Color(0xffE3D7D3),
                  child: Icon(
                    Icons.favorite,
                    size: 20,
                    color: homeScreenProvider.favoriteClothes.contains(item)
                        ? Color(0xff704F38)
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
