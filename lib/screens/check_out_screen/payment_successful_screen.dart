import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentSuccessfulScreen extends StatefulWidget {
  const PaymentSuccessfulScreen({super.key});

  @override
  State<PaymentSuccessfulScreen> createState() =>
      _PaymentSuccessfulScreenState();
}

class _PaymentSuccessfulScreenState extends State<PaymentSuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildAppBar(context),
          buildPaymentSuccessful(),
          SizedBox(
            height: MediaQuery.of(context).size.height / 3.75.h,
          ),
          buildPaymentButton(),
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

  Widget buildPaymentSuccessful() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4.5),
      child: Column(
        children: [
          CircleAvatar(
            minRadius: 50,
            maxRadius: 50,
            backgroundColor: Color(0xff704F38),
            child: Icon(
              Icons.check,
              size: 55,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            "Payment Successful!",
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: Text(
              "Thank you for purchase",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPaymentButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: GestureDetector(
            // onTap: () => Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => BottomNavBarPage(),
            //   ),
            // ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  width: MediaQuery.of(context).size.width.w,
                  height: 54.h,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xff704F38),
                    border: Border.all(color: const Color(0xffDEDEDE)),
                  ),
                  child: Text(
                    "View order",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  "View E-Receipt",
                  style: TextStyle(
                    color: Color(0xff704F38),
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
