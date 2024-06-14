import 'package:khushi_creation/model/cloth_item_model.dart';
import 'package:khushi_creation/model/clothing_item_model.dart';
import 'package:khushi_creation/model/product_details_model.dart';
import 'package:khushi_creation/provider/homes_screen_provider.dart';
import 'package:khushi_creation/screens/filter_screen/filter_screen.dart';
import 'package:khushi_creation/screens/main_screen/filter_category_screen.dart';
import 'package:khushi_creation/screens/product_details_screen/product_details_screen.dart';
import 'package:khushi_creation/screens/search_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khushi_creation/theme/theme_toggle_button.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown/slide_countdown.dart';

class HomeScreen extends StatefulWidget {
  final String? currentLocation;

  const HomeScreen({Key? key, this.currentLocation}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? currentLocation;
  late HomeProviderScreen _homeProviderScreen;
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeProviderScreen =
          Provider.of<HomeProviderScreen>(context, listen: false);
      _homeProviderScreen.installDataLoad();
      _homeProviderScreen.startTimer();
      _homeProviderScreen.fetchLocationFromFirestore();
    });
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Khushi Creation'),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        actions: [
          ThemeToggleButton(),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: 80.h),
            child: Column(
              children: [
                Consumer<HomeProviderScreen>(
                  builder: (context, homeScreenProvider, child) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.0.w, right: 10.w),
                          child: Column(
                            children: [
                              buildLocationTile(),
                              SizedBox(height: 5.h),
                              buildSearchBar(
                                  context: context,
                                  homeScreenProvider: homeScreenProvider),
                              SizedBox(height: 20.h),
                              buildImageSlider(
                                  context: context,
                                  homeScreenProvider: homeScreenProvider),
                              SizedBox(height: 10.h),
                              buildIndicator(
                                  context: context,
                                  homeScreenProvider: homeScreenProvider),
                              SizedBox(height: 15.h),
                              buildCategorySection(context),
                              SizedBox(height: 10.h),
                              buildSalesTitle(),
                              SizedBox(height: 10.h),
                              //
                            ],
                          ),
                        ),
                        buildCategoryItems(
                            context: context,
                            homeScreenProvider: homeScreenProvider),
                        SizedBox(height: 20.h),
                        buildClothItems(
                            context: context,
                            homeScreenProvider: homeScreenProvider),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLocationTile() {
    return Consumer<HomeProviderScreen>(
      builder: (context, homeProvider, child) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text("Your Location"),
          subtitle: Row(
            children: [
              Icon(
                Icons.location_pin,
                color: Color(0xff704F38),
              ),
              SizedBox(width: 8.0),
              if (homeProvider.currentLocation != null)
                Flexible(
                  child: Text(
                    homeProvider.currentLocation!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 14),
                  ),
                )
              else
                Text("Fetching location..."),
              Spacer(),
              CircleAvatar(
                backgroundColor: Color(0xffF1F1F1),
                child: SvgPicture.asset(
                  "assets/svg/notification-bing.svg",
                  colorFilter:
                      ColorFilter.mode(Color(0xFF74523A), BlendMode.srcIn),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildSearchBar({
    required BuildContext context,
    required HomeProviderScreen homeScreenProvider,
  }) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              );
            },
            child: AbsorbPointer(
              child: TextField(
                controller: homeScreenProvider.searchController,
                focusNode: homeScreenProvider.searchFocusNode,
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
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Color(0xffDEDEDE),
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Color(0xffDEDEDE),
                    ),
                  ),
                  prefixIcon: CircleAvatar(
                    minRadius: 25,
                    maxRadius: 25,
                    backgroundColor: Colors.transparent,
                    child: SvgPicture.asset("assets/svg/search-normal-1.svg",
                        colorFilter: ColorFilter.mode(
                            Color(0xFF74523A), BlendMode.srcIn)),
                  ),
                  suffixIcon: homeScreenProvider.searchFocusNode.hasFocus
                      ? GestureDetector(
                          onTap: () {
                            homeScreenProvider.searchController.clear();
                          },
                          child: Icon(
                            Icons.highlight_remove,
                            color: Color(0xff98A2B3),
                          ),
                        )
                      : null,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 199, 199, 199),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FilterScreen(),
            ),
          ),
          child: CircleAvatar(
            backgroundColor: Color(0xff704F38),
            minRadius: 25,
            maxRadius: 25,
            child: SvgPicture.asset("assets/svg/filter.svg",
                colorFilter: ColorFilter.mode(
                    Color.fromARGB(255, 255, 255, 255), BlendMode.srcIn)),
          ),
        ),
      ],
    );
  }

  Widget buildImageSlider(
      {required BuildContext context,
      required HomeProviderScreen homeScreenProvider}) {
    return Container(
      height: MediaQuery.of(context).size.height / 5.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: PageView.builder(
        controller: homeScreenProvider.pageController,
        onPageChanged: (int index) {
          if (_isMounted) {
            homeScreenProvider.setCurrentIndex(
                index % homeScreenProvider.sliderModel.images.length);
          }
        },
        itemBuilder: (context, index) {
          final int pageIndex =
              index % homeScreenProvider.sliderModel.images.length;
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              homeScreenProvider.sliderModel.images[pageIndex],
              height: 20,
              width: 100,
              fit: BoxFit.fitWidth,
            ),
          );
        },
      ),
    );
  }

  Widget buildIndicator(
      {required BuildContext context,
      required HomeProviderScreen homeScreenProvider}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        homeScreenProvider.sliderModel.images.length,
        (index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 3.w),
            width: homeScreenProvider.currentIndex == index ? 10.w : 10.w,
            height: 10.h,
            decoration: BoxDecoration(
              color: homeScreenProvider.currentIndex == index
                  ? Color(0xff704F38)
                  : Color(0xffDEDEDE),
              borderRadius: BorderRadius.circular(4.r),
            ),
          );
        },
      ),
    );
  }

  Widget buildCategorySection(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Category",
              style: TextStyle(fontSize: 20.sp),
            ),
            Text(
              "View All",
              style: TextStyle(
                color: Color(0xff704F38),
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var item in clothingItemsModel)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FilteredClothesScreen(wishListCategories: item.name),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        backgroundColor: Color(0xffF7F2ED),
                        child: SvgPicture.asset(item.svgPath,
                            width: 40,
                            height: 40,
                            colorFilter: ColorFilter.mode(
                                Color(0xFF74523A), BlendMode.srcIn)),
                        radius: 30,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(item.name),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget buildSalesTitle() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Flash Sale",
              style: TextStyle(fontSize: 20.sp),
            ),
            SizedBox(width: 10),
            Text(
              "Closing in :",
              style: TextStyle(fontSize: 15.sp, color: Colors.grey),
            ),
            SlideCountdownSeparated(
              decoration: BoxDecoration(
                color: Color(0xffEEE5DB),
                borderRadius: BorderRadius.circular(5),
              ),
              style: TextStyle(
                color: Color(0xff704F38),
              ),
              duration: const Duration(hours: 2),
            ),
          ],
        ),
      ],
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
            itemCount: homeScreenProvider.categories.length,
            itemBuilder: (context, index) {
              return buildCategorySectionSlider(
                  context, index, homeScreenProvider.categories[index],
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
    final brightness = Theme.of(context).brightness;

    return GestureDetector(
      onTap: () {
        homeScreenProvider.updateCatogryData(index: index);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Container(
          height: 40.h,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: homeScreenProvider.selectedCategoryIndex == index
                ? Color(0xff704F38)
                : Colors.transparent,
            border: homeScreenProvider.selectedCategoryIndex == index
                ? null
                : Border.all(color: Color(0xffD0D5DD)),
          ),
          child: Center(
            child: Text(
              categoryName,
              style: TextStyle(
                color: homeScreenProvider.selectedCategoryIndex == index
                    ? Color.fromARGB(255, 255, 255, 255)
                    : (brightness == Brightness.light
                        ? Colors.black
                        : Color.fromARGB(255, 255, 255, 255)),
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildClothItems({
    required BuildContext context,
    required HomeProviderScreen homeScreenProvider,
  }) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.75,
        ),
        itemCount: homeScreenProvider.filteredClothes.length,
        itemBuilder: (context, index) {
          ClothItemModel clothes = homeScreenProvider.filteredClothes[index];

          return buildCard(
            context: context,
            clothes: clothes,
            index: index,
            homeProviderScreen: homeScreenProvider,
          );
        },
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
                    homeProviderScreen.favoriteClothes.contains(clothes),
                imagePaths: [],
                selectedImageIndex: index,
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
