import 'package:khushi_creation/model/cloth_item_model.dart';
import 'package:khushi_creation/model/product_details_model.dart';
import 'package:khushi_creation/screens/product_details_screen/product_details_screen.dart';
import 'package:khushi_creation/provider/homes_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeScreenProvider = Provider.of<HomeProviderScreen>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final query = homeScreenProvider.searchController.text;
          if (query.isNotEmpty) {
            homeScreenProvider.searchData(value: query);
          }
          return Future.delayed(Duration(milliseconds: 200));
        },
        color: Color(0xff704F38),
        backgroundColor: Colors.white,
        strokeWidth: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildSearchTextField(homeScreenProvider),
              SizedBox(height: 16),
              _buildBodyContent(homeScreenProvider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchTextField(HomeProviderScreen homeProviderScreen) {
    return TextField(
      controller: homeProviderScreen.searchController,
      focusNode: homeProviderScreen.searchFocusNode,
      onChanged: (value) => homeProviderScreen.searchData(value: value),
      onSubmitted: (value) => homeProviderScreen.searchData(value: value),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: Color(0xffDEDEDE),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: Color(0xffDEDEDE),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: Color(0xffDEDEDE),
          ),
        ),
        prefixIcon: _buildPrefixIcon(),
        suffixIcon: homeProviderScreen.searchController.text.isNotEmpty
            ? _buildClearIcon(homeProviderScreen)
            : null,
        hintText: 'Search',
        hintStyle: TextStyle(
          color: const Color.fromARGB(255, 199, 199, 199),
        ),
      ),
    );
  }

  Widget _buildPrefixIcon() {
    return CircleAvatar(
      minRadius: 25,
      maxRadius: 25,
      backgroundColor: Colors.transparent,
      child: SvgPicture.asset(
        "assets/svg/search-normal-1.svg",
          colorFilter: ColorFilter.mode(Color(0xFF74523A), BlendMode.srcIn)
      ),
    );
  }

  Widget _buildClearIcon(HomeProviderScreen homeProviderScreen) {
    return GestureDetector(
      onTap: () {
        homeProviderScreen
            .addRecentSearch(homeProviderScreen.searchController.text);
        homeProviderScreen.searchController.clear();
        homeProviderScreen.searchData(value: '');
      },
      child: Icon(
        Icons.highlight_remove,
        color: Color(0xff704F38),
      ),
    );
  }

  Widget _buildBodyContent(HomeProviderScreen homeProviderScreen) {
    if (homeProviderScreen.searchController.text.isEmpty) {
      return _buildRecentSearches(homeProviderScreen);
    } else {
      return _buildSearchResults(homeProviderScreen);
    }
  }

  Widget _buildRecentSearches(HomeProviderScreen homeProviderScreen) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Divider(),
          SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: homeProviderScreen.recentSearches.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(homeProviderScreen.recentSearches[index]),
                  onTap: () {
                    homeProviderScreen.searchController.text =
                        homeProviderScreen.recentSearches[index];
                    homeProviderScreen.searchData(
                        value: homeProviderScreen.recentSearches[index]);
                  },
                  trailing: IconButton(
                    icon: Icon(
                      Icons.highlight_remove,
                      color: Color(0xff704F38),
                    ),
                    onPressed: () {
                      homeProviderScreen.recentSearches.removeAt(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(HomeProviderScreen homeProviderScreen) {
    return _buildClothItems(homeProviderScreen: homeProviderScreen);
  }

  Widget _buildClothItems({required HomeProviderScreen homeProviderScreen}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 10.0.w, right: 10.0.w, top: 10.0.h),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          itemCount: homeProviderScreen.filteredClothes.length,
          itemBuilder: (context, index) {
            final clothes = homeProviderScreen.filteredClothes[index];
            return buildCard(
              context: context,
              clothes: clothes,
              homeProviderScreen: homeProviderScreen,
              index: index,
            );
          },
        ),
      ),
    );
  }

  Widget buildCard({
    required BuildContext context,
    required ClothItemModel clothes,
    required int index,
    required HomeProviderScreen homeProviderScreen,
  }) {
    return Container(
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
              productDetailsModel: ProductDetailsModel(
                clothes: clothes,
                onFavoriteToggle: (isFavorite) {},
                isFavorite:
                    homeProviderScreen.favoriteClothes.contains(clothes), imagePaths: [], selectedImageIndex:0,
              ),
            ),
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      width: MediaQuery.of(context).size.width,
                      clothes.imagePath,
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
                        clothes.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          clothes.icon,
                          SizedBox(width: 5),
                          Text(clothes.rating.toString()),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '\u{20B9}${clothes.price}',
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
                  homeProviderScreen.updateFavoriteData(id: clothes.id);
                },
                child: CircleAvatar(
                  maxRadius: 15,
                  minRadius: 15,
                  backgroundColor: Color(0xffE3D7D3),
                  child: homeProviderScreen.favoriteClothes.contains(clothes)
                      ? Icon(
                          Icons.favorite,
                          size: 20,
                          color: Color(0xff704F38),
                        )
                      : Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: Color(0xff704F38),
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
