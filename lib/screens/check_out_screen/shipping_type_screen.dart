import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/shipping_type_model.dart';

class ShippingTypeScreen extends StatefulWidget {
  const ShippingTypeScreen({super.key});

  @override
  State<ShippingTypeScreen> createState() => _ShippingTypeScreenState();
}

class _ShippingTypeScreenState extends State<ShippingTypeScreen> {
  String? _selectedValue;

  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedValue = value;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You Choose: $_selectedValue'),
        duration: Duration(seconds: 1),
        backgroundColor: Color(0xff704F38),
        elevation: 5.5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: ListView(
              children: [
                ShippingTypeModel(
                  type: "Economy",
                  estimatedDate: "Estimated DeliveryDate is 25 Aug",
                  value: "Economy Type",
                  groupValue: _selectedValue,
                  onChanged: _handleRadioValueChange,
                ),
                Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                ShippingTypeModel(
                  type: "Regular",
                  estimatedDate: "Estimated DeliveryDate is 23 Aug",
                  value: "Regular Type",
                  groupValue: _selectedValue,
                  onChanged: _handleRadioValueChange,
                ),
                Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                ShippingTypeModel(
                  type: "Cargo",
                  estimatedDate: "Estimated DeliveryDate is 22 Aug",
                  value: "Cargo Type",
                  groupValue: _selectedValue,
                  onChanged: _handleRadioValueChange,
                ),
                Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                ShippingTypeModel(
                  type: "Home",
                  estimatedDate: "1901 Thornridge Cir. Shiloh, Hawaii 81662",
                  value: "Home Address",
                  groupValue: _selectedValue,
                  onChanged: _handleRadioValueChange,
                ),
              ],
            ),
          ),
          _buildApplyButton(),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, top: 40.0.h, right: 20.0.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffE6E6E6),
                  width: 2,
                ),
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
          SizedBox(width: 50.w),
          Text(
            "Shipping Address",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildApplyButton() {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Color(0xff704F38),
                  borderRadius: BorderRadius.circular(50)),
              alignment: Alignment.center,
              height: 50.h,
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Apply",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
