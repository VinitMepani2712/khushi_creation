import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:khushi_creation/provider/cart_screen_provider.dart';

class DeliveryTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Shipping'),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: [
          _buildDeliveryOption(
              context, 'Economy', 00.0, 'Estimated Arrival: 25 August 2023'),
          _buildDeliveryOption(
              context, 'Regular', 50.0, 'Estimated Arrival: 20 August 2023'),
          _buildDeliveryOption(
              context, 'Cargo', 80.0, 'Estimated Arrival: 18 August 2023'),
          _buildDeliveryOption(
              context, 'Express', 100.0, 'Estimated Arrival: 15 August 2023'),
        ],
      ),
    );
  }

  Widget _buildDeliveryOption(
      BuildContext context, String type, double fee, String description) {
    return ListTile(
      leading: Icon(Icons.local_shipping_outlined, color: Color(0xff704F38)),
      title: Text(type),
      subtitle: Text(description),
      trailing: Text(
        '\u{20B9}${fee.toStringAsFixed(2)}',
        style: TextStyle(fontSize: 14.0),
      ),
      onTap: () {
        Provider.of<CartProvider>(context, listen: false).setDeliveryFee(fee);
        Navigator.pop(context, type);
      },
    );
  }
}
