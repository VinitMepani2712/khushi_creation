import 'package:khushi_creation/model/coupan_model/coupan_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/coupan_model/coupan_content_model.dart';

class CouponScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(left: 10.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(context),
          Padding(
            padding: EdgeInsets.only(left: 15.0.w, top: 20.h),
            child: Text("Best Offers for You"),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: coupons.length,
              itemBuilder: (context, index) {
                return buildCoupanCode(context, coupons[index]);
              },
            ),
          ),
        ],
      ),
    ));
  }
}

Widget _buildAppBar(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(
      top: 40.0.h,
    ),
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

Widget buildCoupanCode(BuildContext context, CouponCardModel coupon) {
  return Card(
    margin: EdgeInsets.only(bottom: 16.0),
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            coupon.code,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            coupon.description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            coupon.offer,
            style: TextStyle(
              fontSize: 16,
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: () {
              // Handle copy code functionality
            },
            child: Text('COPY CODE'),
          ),
        ],
      ),
    ),
  );
}
