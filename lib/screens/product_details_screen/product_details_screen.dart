import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khushi_creation/model/cart_model.dart';
import 'package:khushi_creation/model/cloth_item_model.dart';
import 'package:khushi_creation/model/product_details_model.dart';
import 'package:khushi_creation/provider/cart_screen_provider.dart';
import 'package:khushi_creation/provider/homes_screen_provider.dart';
import 'package:khushi_creation/provider/product_details_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductDetailsModel productDetailsModel;

  ProductDetailsScreen({required this.productDetailsModel});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late bool isFavorite;
  List<String> imagePaths = [
    'assets/images/man/man1.jpg',
    'assets/images/woman/woman2.jpg',
    'assets/images/woman/woman3.jpg',
    'assets/images/woman/woman4.jpg',
    'assets/images/woman/woman5.jpg',
  ];

  @override
  void initState() {
    super.initState();
    isFavorite = widget.productDetailsModel.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    ProductDetailsProvider productDetailsProvider =
        Provider.of<ProductDetailsProvider>(context, listen: false);
    HomeProviderScreen homeProviderScreen =
        Provider.of<HomeProviderScreen>(context, listen: false);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 80.h),
            child: Column(
              children: [
                _buildProductImage(homeProviderScreen),
                _buildProductDetails(cartProvider, productDetailsProvider),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildPriceAndAddToCartButton(
                cartProvider, productDetailsProvider),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage(HomeProviderScreen homeProviderScreen) {
    return Stack(
      children: [
        Image.asset(
          widget.productDetailsModel.clothes.imagePath,
          height: MediaQuery.of(context).size.height / 2.h,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0.w, top: 40.0.h, right: 20.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context, isFavorite),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffFFFFFF),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: CircleAvatar(
                    minRadius: 20,
                    maxRadius: 20,
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.arrow_back,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                  homeProviderScreen.updateFavoriteData(
                      id: widget.productDetailsModel.clothes.id);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffFFFFFF),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: CircleAvatar(
                    minRadius: 20,
                    maxRadius: 20,
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Color(0xff704F38),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10.h,
          left: 0,
          right: 0,
          child: _buildImageThumbnails(),
        ),
      ],
    );
  }

  Widget _buildImageThumbnails() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 05.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: imagePaths.map((path) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  widget.productDetailsModel.clothes.imagePath = path;
                });
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  path,
                  width: 60.w,
                  height: 60.h,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildProductDetails(CartProvider cartProvider,
      ProductDetailsProvider productDetailsProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProductRating(),
        SizedBox(height: 8),
        _buildProductName(),
        SizedBox(height: 8),
        _buildSectionTitle('Product Details'),
        SizedBox(height: 8),
        _buildProductDescription(),
        SizedBox(height: 8),
        _buildSectionTitle('Select Size'),
        SizedBox(height: 8),
        _buildSizeSelector(),
        SizedBox(height: 8),
        _buildSelectedColorText(),
        SizedBox(height: 8),
        _buildColorSelector(),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildProductRating() {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.productDetailsModel.clothes.style,
            style: TextStyle(
              fontSize: 16.sp,
              color: Color(0xff979797),
            ),
          ),
          Row(
            children: [
              widget.productDetailsModel.clothes.icon,
              SizedBox(width: 4),
              Text(widget.productDetailsModel.clothes.rating.toString(),
                  style: TextStyle(fontSize: 18)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        widget.productDetailsModel.clothes.name,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildProductDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Read more',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildSizeSelector() {
    return Consumer<ProductDetailsProvider>(
      builder: (context, productDetailsProvider, child) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: ClothSize.values.map((size) {
                final bool isSelected =
                    productDetailsProvider.selectedSize == size;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                  child: ChoiceChip(
                    showCheckmark: false,
                    label: Text(
                      size.toString().split('.').last,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      productDetailsProvider.setSelectedSize(size);
                    },
                    selectedColor: Colors.brown,
                    backgroundColor: Colors.transparent,
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildColorSelector() {
    return Consumer<ProductDetailsProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: EdgeInsets.only(left: 10.0, bottom: 20.0),
          child: Row(
              children: List.generate(
            EnumColor.values.length,
            (index) {
              EnumColor selectedColor = EnumColor.values[index];
              return GestureDetector(
                onTap: () {
                  provider.setSelectedColor(selectedColor);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: colorName(selectedColor),
                        radius: 16,
                      ),
                      if (provider.selectedColor?.name == selectedColor.name)
                        CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          radius: 4,
                        ),
                    ],
                  ),
                ),
              );
            },
          )),
        );
      },
    );
  }

  Widget _buildSelectedColorText() {
    return Consumer<ProductDetailsProvider>(
      builder: (context, provider, child) {
        String colorName = provider.selectedColor == EnumColor.values
            ? (provider.selectedColor?.name ?? "")
            : "${provider.selectedColor?.name}";
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Selected color : $colorName',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }

  Color colorName(EnumColor color) {
    if (color == EnumColor.Blue) {
      return Colors.blue;
    } else if (color == EnumColor.Brown) {
      return Colors.brown;
    } else if (color == EnumColor.Orange) {
      return Colors.orange;
    } else if (color == EnumColor.Black) {
      return Colors.black;
    } else {
      return Colors.transparent;
    }
  }

  Widget _buildPriceAndAddToCartButton(CartProvider cartProvider,
      ProductDetailsProvider productDetailsProvider) {
    return Card(
      elevation: 2,
      shadowColor: Color.fromARGB(197, 235, 235, 238),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'Final Price :',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff797979),
                      ),
                    ),
                    Text(
                      '\u{20B9}${widget.productDetailsModel.clothes.price}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.brown),
                  ),
                  onPressed: () {
                    final snackBar = SnackBar(
                      content: Row(
                        children: [
                          Text(
                            ' ${widget.productDetailsModel.clothes.name} Added to the cart',
                            style: TextStyle(
                                color: Color.fromARGB(223, 255, 255, 255)),
                          ),
                        ],
                      ),
                      backgroundColor: Colors.brown,
                      duration: Duration(milliseconds: 500),
                    );

                    ClothItemModel clothItemModel = ClothItemModel(
                      id: widget.productDetailsModel.clothes.id,
                      style: widget.productDetailsModel.clothes.style,
                      imagePath: widget.productDetailsModel.clothes.imagePath,
                      name: widget.productDetailsModel.clothes.name,
                      icon: widget.productDetailsModel.clothes.icon,
                      rating: widget.productDetailsModel.clothes.rating,
                      price: widget.productDetailsModel.clothes.price,
                      categories: widget.productDetailsModel.clothes.categories,
                      wishListCategories:
                          widget.productDetailsModel.clothes.wishListCategories,
                      isFavourite:
                          widget.productDetailsModel.clothes.isFavourite,
                      selectedColor: productDetailsProvider.selectedColor,
                      selectedSize: productDetailsProvider.selectedSize,
                    );
                    cartProvider.addItem(
                        CartItem(clothes: clothItemModel, quantity: 1));
                    cartItems.add(
                      CartItem(
                        clothes: widget.productDetailsModel.clothes,
                        quantity: 1,
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/svg/shopping-bag.svg",
                          colorFilter: ColorFilter.mode(
                              Color.fromARGB(255, 255, 255, 255), BlendMode.srcIn)
                      ),
                      SizedBox(width: 10.h),
                      Text(
                        'Add to Cart',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
