import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khushi_creation/provider/homes_screen_provider.dart';
import 'package:khushi_creation/screens/check_out_screen/shipping_address_screen.dart';
import 'package:khushi_creation/screens/check_out_screen/shipping_type_screen.dart';
import 'package:provider/provider.dart';
import 'package:khushi_creation/provider/cart_screen_provider.dart';
import 'package:khushi_creation/model/cart_model.dart';

class CheckOutScreen extends StatefulWidget {
  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  String _selectedShippingType = 'Economy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return ListView(
            padding: EdgeInsets.all(10.0),
            children: [
              _buildShippingAddressSection(context),
              SizedBox(height: 10.0),
              _buildShippingTypeSection(context),
              SizedBox(height: 10.0),
              _buildOrderListSection(context, cartProvider),
            ],
          );
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildShippingAddressSection(BuildContext context) {
    return Consumer<HomeProviderScreen>(
      builder: (context, homeProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shipping Address',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: Icon(
                Icons.location_pin,
                color: Color(0xff704F38),
              ),
              title: Text(homeProvider.currentAddressType ?? 'Home'),
              subtitle: homeProvider.currentLocation != null
                  ? Text(
                      homeProvider.currentLocation!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 10,
                      style: TextStyle(fontSize: 14),
                    )
                  : Text("Fetching location..."),
              trailing: TextButton(
                onPressed: () async {
                  final selectedAddress = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddressSelectionScreen()),
                  );
                  if (selectedAddress != null) {
                    homeProvider.setCurrentLocation(
                      selectedAddress['address'],
                      selectedAddress['addressType'],
                    );
                  }
                },
                child: Text('CHANGE', style: TextStyle(color: Colors.brown)),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildShippingTypeSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Choose Shipping Type',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
        ListTile(
          leading: Icon(Icons.local_shipping, color: Color(0xff704F38)),
          title: Text(_selectedShippingType),
          subtitle: Text(_getEstimatedArrival(_selectedShippingType)),
          trailing: TextButton(
            onPressed: () async {
              final selectedType = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeliveryTypeScreen()),
              );
              if (selectedType != null) {
                setState(() {
                  _selectedShippingType = selectedType;
                });
              }
            },
            child: Text('CHANGE', style: TextStyle(color: Colors.brown)),
          ),
        ),
      ],
    );
  }

  String _getEstimatedArrival(String shippingType) {
    switch (shippingType) {
      case 'Economy':
        return 'Estimated Arrival: 25 August 2023';
      case 'Regular':
        return 'Estimated Arrival: 20 August 2023';
      case 'Cargo':
        return 'Estimated Arrival: 18 August 2023';
      case 'Express':
        return 'Estimated Arrival: 15 August 2023';
      default:
        return 'Estimated Arrival: Unknown';
    }
  }

  Widget _buildOrderListSection(
      BuildContext context, CartProvider cartProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Order List',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: cartProvider.items.length,
          itemBuilder: (context, index) {
            final cartItem = cartProvider.items[index];
            return _buildOrderItem(cartItem);
          },
        ),
      ],
    );
  }

  Widget _buildOrderItem(CartItem cartItem) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              cartItem.clothes.imagePath,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.clothes.name,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text('Size: ${cartItem.clothes.selectedSize?.name}'),
                  SizedBox(height: 5.0),
                  Text(
                    'Color: ${cartItem.clothes.selectedColor?.name}',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Color.fromARGB(255, 255, 255, 255)
                          : Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'Quantity: ${cartItem.quantity}',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Container(
          padding: EdgeInsets.only(
              top: 10.0.h, left: 10.0.w, right: 10.0.w, bottom: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSummaryRow('Sub Total:', cartProvider.subtotal),
              SizedBox(height: 5.0),
              _buildSummaryRow('Delivery Fee:', cartProvider.deliveryFee),
              SizedBox(height: 5.0),
              _buildSummaryRow('Discount:', -cartProvider.discount),
              Divider(),
              _buildSummaryRow('Total Cost:', cartProvider.totalPrice,
                  isTotal: true),
              SizedBox(height: 10.0),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.brown),
                  minimumSize: WidgetStateProperty.all<Size>(
                      Size(MediaQuery.of(context).size.width, 50)),
                ),
                onPressed: () {},
                child: Text('Continue to Payment',
                    style: TextStyle(color: Colors.white, fontSize: 18.0)),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryRow(String label, double value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: Colors.black,
          ),
        ),
        Text(
          '\u{20B9}${value.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
