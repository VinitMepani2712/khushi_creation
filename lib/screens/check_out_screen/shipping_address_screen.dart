import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../model/shipping_address_model.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
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
                ShippingAddressModel(
                  addressType: "Home",
                  address: "1901 Thornridge Cir. Shiloh, Hawaii 81662",
                  value: "Home Address",
                  groupValue: _selectedValue,
                  onChanged: _handleRadioValueChange,
                ),
                Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                ShippingAddressModel(
                  addressType: "Work",
                  address: "1234 Elm St. Springfield, Illinois 62704",
                  value: "Work Address",
                  groupValue: _selectedValue,
                  onChanged: _handleRadioValueChange,
                ),
                Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                ShippingAddressModel(
                  addressType: "Other",
                  address: "5678 Oak Dr. Lincoln, Nebraska 68508",
                  value: "Other Address",
                  groupValue: _selectedValue,
                  onChanged: _handleRadioValueChange,
                ),
                Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                ShippingAddressModel(
                  addressType: "Vacation",
                  address: "4321 Maple Ave. Denver, Colorado 80220",
                  value: "Vacation Address",
                  groupValue: _selectedValue,
                  onChanged: _handleRadioValueChange,
                ),
                SizedBox(height: 30),
                _buildAddNewAddressButton(),
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

  Widget _buildAddNewAddressButton() {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Column(
        children: [
          DottedBorder(
            color: Color(0xff704F38),
            strokeWidth: 1,
            dashPattern: [4, 2],
            borderType: BorderType.RRect,
            radius: Radius.circular(5),
            child: Container(
              height: 50.h,
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  Text(
                    "Add New Shipping Address",
                  ),
                ],
              ),
            ),
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
                borderRadius: BorderRadius.circular(50),
              ),
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
