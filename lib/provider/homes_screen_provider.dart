import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../model/cloth_item_model.dart';
import '../../model/silder_model.dart';
import '../model/cloth_item_model_content.dart';

class HomeProviderScreen with ChangeNotifier {
  final SliderModel sliderModel = SliderModel();
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  String? _currentLocation;

  String? get currentLocation => _currentLocation;

  int currentIndex = 0;
  int selectedCategoryIndex = 0;
  int selectedWishListCategoryIndex = 0;
  List<String> categories = ['All', 'Newest', 'Popular', 'Man', 'Woman'];
  List<String> wishListCategories = [
    'All',
    'Jacket',
    'Shirt',
    'Pants',
    'T-Shirt',
    'Dress',
  ];

  Timer? _timer;
  PageController pageController = PageController();

  List<ClothItemModel> allClothesData = [];
  List<ClothItemModel> filteredClothes = [];
  List<ClothItemModel> favoriteClothes = [];
  List<ClothItemModel> filteredFavoriteClothes = [];

  List<String> recentSearches = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void installDataLoad() {
    allClothesData.clear();
    filteredClothes.clear();
    filteredFavoriteClothes.clear();

    allClothesData.addAll(clothItemModel);
    filteredClothes.addAll(allClothesData);
    favoriteClothes = allClothesData.where((item) => item.isFavourite).toList();
    filteredFavoriteClothes.addAll(favoriteClothes);
    notifyListeners();
  }

  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void updateCatogryData({required int index}) {
    filteredClothes = [];

    if (index == 0) {
      selectedCategoryIndex = index;
      filteredClothes.addAll(allClothesData);
      notifyListeners();
      return;
    }
    selectedCategoryIndex = index;

    for (var data in allClothesData) {
      if (data.categories.contains(categories[index])) {
        filteredClothes.add(data);
      }
    }
    notifyListeners();
  }

  void updateWishListCatogryData({required int index}) {
    filteredFavoriteClothes = [];

    if (index == 0) {
      selectedWishListCategoryIndex = index;
      filteredFavoriteClothes.addAll(favoriteClothes);
      notifyListeners();
      return;
    }
    selectedWishListCategoryIndex = index;

    for (var data in favoriteClothes) {
      if (data.wishListCategories.contains(wishListCategories[index])) {
        filteredFavoriteClothes.add(data);
      }
    }
    notifyListeners();
  }

  void updateFavoriteData({required int id}) {
    for (var data in allClothesData) {
      if (data.id == id) {
        data.isFavourite = !data.isFavourite;
        if (data.isFavourite) {
          favoriteClothes.add(data);
        } else {
          favoriteClothes.removeWhere((item) => item.id == id);
        }
        filteredFavoriteClothes = favoriteClothes
            .where((item) =>
                item.wishListCategories.contains(
                    wishListCategories[selectedWishListCategoryIndex]) ||
                selectedWishListCategoryIndex == 0)
            .toList();
        notifyListeners();
        break;
      }
    }
  }

  void searchData({required String value}) {
    _setLoading(true);
    List<ClothItemModel> tempList = [];

    for (var data in allClothesData) {
      if (selectedCategoryIndex == 0) {
        if (data.name.toLowerCase().contains(value.toLowerCase())) {
          tempList.add(data);
          notifyListeners();
        }
        notifyListeners();
      } else if (data.name.toLowerCase().contains(value.toLowerCase()) &&
          (data.categories.contains(categories[selectedCategoryIndex]))) {
        tempList.add(data);
        notifyListeners();
      }
      notifyListeners();
    }
    filteredClothes = tempList;
    _setLoading(false);
    notifyListeners();
  }

  void addRecentSearch(String search) {
    if (recentSearches.contains(search)) {
      recentSearches.remove(search);
    }
    recentSearches.insert(0, search);
    if (recentSearches.length > 10) {
      recentSearches = recentSearches.sublist(0, 10);
    }
    notifyListeners();
  }

  void clearRecentSearches() {
    recentSearches.clear();
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setCurrentLocation(String? location) {
    _currentLocation = location;
    notifyListeners();
  }

  Future<void> fetchLocation() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      _currentLocation = doc['location'];
      notifyListeners();
    }
  }
}
