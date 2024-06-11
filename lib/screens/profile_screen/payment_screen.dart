import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        children: [
          _buildAppBar(context),
          SizedBox(height: 20),
          _buildMenuItems(),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.0.w, top: 40.0.h, right: 20.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                "Payment Methods",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItems() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Credit & Debit Card",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10.h),
          ProfileMenuItem(
            icon: Icons.credit_card,
            iconColor: Color(0xff704F38),
            text: 'Add New Card',
          ),
          SizedBox(height: 20.h),
          Text(
            "More Payment Options",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10.h),
          ProfileMenuItem(
            icon: FontAwesomeIcons.paypal,
            iconColor: Color(0xff00186A),
            text: 'Paypal',
          ),
          SizedBox(height: 20.h),
          ProfileMenuItem(
            icon: Icons.apple,
            text: 'Apple Pay',
          ),
        ],
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData? icon;
  final String text;
  final Color? iconColor;

  ProfileMenuItem({this.icon, required this.text, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Color(0xffE6E6E6),
              width: 2,
            ),
          ),
          child: ListTile(
            leading: icon != null ? Icon(icon, color: iconColor) : null,
            title: Text(text),
            trailing: Text(
              "Link",
              style: TextStyle(
                color: Color(0xff704F38),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
