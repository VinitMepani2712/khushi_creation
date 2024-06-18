import 'package:khushi_creation/model/cart_model.dart';
import 'package:khushi_creation/provider/cart_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khushi_creation/screens/check_out_screen/check_out_screen.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return cartProvider.items.isEmpty
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Looks like your cart is currently empty. Time to fill it up with goodies! 🛒",
                      style: TextStyle(fontSize: 18.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartProvider.items[index];
                    return _buildCartItem(cartItem, context);
                  },
                );
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.items.isEmpty) {
            return SizedBox();
          } else {
            return Container(
              padding: EdgeInsets.only(bottom: 90.0.h),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? Color.fromARGB(255, 255, 255, 255)
                    : Color.fromARGB(255, 0, 0, 0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 20),
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
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide(
                                        color: Color(0xffDEDEDE),
                                      ),
                                    ),
                                    hintText: 'Promo Code',
                                    hintStyle: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Color.fromARGB(255, 255, 255, 255)
                                          : Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 10,
                                  child: TextButton(
                                    style: ButtonStyle(
                                      minimumSize: WidgetStateProperty.all(
                                        Size(
                                            MediaQuery.of(context).size.width /
                                                3.8.w,
                                            40.h),
                                      ),
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                              Colors.brown),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      'Apply',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sub Total:',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color.fromARGB(255, 255, 255, 255)
                                    : Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        Text(
                          '\u{20B9}${cartProvider.subtotal.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color.fromARGB(255, 255, 255, 255)
                                    : Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery Fee:',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color.fromARGB(255, 255, 255, 255)
                                    : Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        Text(
                          '\u{20B9}${cartProvider.deliveryFee.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color.fromARGB(255, 255, 255, 255)
                                    : Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Discount:',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color.fromARGB(255, 255, 255, 255)
                                    : Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        Text(
                          '-\u{20B9}${cartProvider.discount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color.fromARGB(255, 255, 255, 255)
                                    : Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Cost:',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color.fromARGB(255, 255, 255, 255)
                                    : Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        Text(
                          '\u{20B9}${cartProvider.totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color.fromARGB(255, 255, 255, 255)
                                    : Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    TextButton(
                      style: ButtonStyle(
                        minimumSize: WidgetStateProperty.all(
                          Size(MediaQuery.of(context).size.width / 1.2, 40),
                        ),
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.brown),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (contex) => CheckOutScreen(),
                        ),
                      ),
                      child: Text(
                        'Proceed to Checkout',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<bool?> showDeleteConfirmation(
      CartItem cartItem, BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Remove from Cart?",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Divider(),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width / 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        cartItem.clothes.imagePath,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartItem.clothes.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Size: ${cartItem.clothes.selectedSize}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Color: ${cartItem.clothes.selectedColor}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('\u{20B9}${cartItem.clothes.price}'),
                            _buildQuantityControl(cartItem, context),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      minimumSize: WidgetStateProperty.all(
                        Size(MediaQuery.of(context).size.width / 2.5, 40),
                      ),
                      backgroundColor: WidgetStateProperty.all<Color>(
                        Color(0xffEDEDED),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Color(0xff704F38),
                      ),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      minimumSize: WidgetStateProperty.all(
                        Size(MediaQuery.of(context).size.width / 2.5, 40),
                      ),
                      backgroundColor: WidgetStateProperty.all<Color>(
                        Color(0xff704F38),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(
                      "Yes, Remove",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCartItem(CartItem cartItem, BuildContext context) {
    return Dismissible(
      key: Key(cartItem.toString()),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDeleteConfirmation(cartItem, context);
      },
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false).removeItem(cartItem);
      },
      background: Container(
        color: const Color.fromARGB(255, 252, 178, 172),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        alignment: AlignmentDirectional.centerEnd,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 6,
                width: MediaQuery.of(context).size.width / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    cartItem.clothes.imagePath,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItem.clothes.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Size: ${cartItem.clothes.selectedSize?.name}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'Color: ${cartItem.clothes.selectedColor?.name}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Color.fromARGB(255, 255, 255, 255)
                            : Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('\u{20B9}${cartItem.clothes.price}'),
                        _buildQuantityControl(cartItem, context),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityControl(CartItem cartItem, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF0F4EF),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? Color.fromARGB(255, 209, 200, 200)
                : Color.fromARGB(255, 240, 235, 235),
            child: IconButton(
              icon: Icon(Icons.remove),
              onPressed: () async {
                if (cartItem.quantity > 1) {
                  Provider.of<CartProvider>(context, listen: false)
                      .decrementQuantity(cartItem);
                } else {
                  final confirmDelete =
                      await showDeleteConfirmation(cartItem, context);
                  if (confirmDelete == true) {
                    Provider.of<CartProvider>(context, listen: false)
                        .removeItem(cartItem);
                  }
                }
              },
            ),
          ),
          SizedBox(width: 5.0),
          Text(
            cartItem.quantity.toString(),
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          SizedBox(width: 10.0),
          CircleAvatar(
            backgroundColor: Color(0xff704F38),
            child: IconButton(
              icon: Icon(Icons.add, color: Colors.white),
              onPressed: () => Provider.of<CartProvider>(context, listen: false)
                  .incrementQuantity(cartItem),
            ),
          ),
        ],
      ),
    );
  }
}
