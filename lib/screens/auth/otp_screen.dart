import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khushi_creation/widget/widget_support.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String email = "garib7822@gmail.com";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(top: 70.h, left: 20.w, right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBackButton(context),
                SizedBox(height: 20.h),
                _buildHeaderText(),
                SizedBox(height: 20.h),
                _buildEmailText(),
                SizedBox(height: 50.h),
                _buildOtpFields(context),
                SizedBox(height: 50.h),
                _buildResendText(),
                SizedBox(height: 40.h),
                _buildVerifyButton(context),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromARGB(255, 192, 192, 192),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: CircleAvatar(
          minRadius: 20,
          maxRadius: 20,
          backgroundColor: Colors.transparent,
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return Center(
      child: Text(
        "Verify Code",
        textAlign: TextAlign.center,
        style: AppWidget.textStyle(),
      ),
    );
  }

  Widget _buildEmailText() {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Please enter the code we just sent to email ',
          style: AppWidget.lightTextStyle(),
          children: [
            TextSpan(
              text: '$email',
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Color(0xff704F38),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpFields(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (index) {
        return SizedBox(
          width: MediaQuery.of(context).size.width / 5.w,
          child: TextFormField(
            textAlign: TextAlign.center,
            decoration: _inputDecoration(),
            style: TextStyle(color: Colors.black),
          ),
        );
      }),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(
          color: Color(0xFFC4C4C4),
        ),
      ),
      errorBorder: OutlineInputBorder(
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
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(
          color: Color(0xFFFFFFFF),
        ),
      ),
      fillColor: Color.fromRGBO(64, 123, 255, 0.03),
      filled: true,
      hintText: "-",
      hintStyle: TextStyle(color: Color(0xff858383)),
      border: InputBorder.none,
    );
  }

  Widget _buildResendText() {
    return Column(
      children: [
        Text(
          "Did't Receive OTP?",
          style: AppWidget.lightTextStyle(),
        ),
        Text(
          "Resend Code",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xff704F38),
            fontWeight: FontWeight.w700,
            fontSize: 16.sp,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }

  Widget _buildVerifyButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 54.h,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Color(0xff704F38),
        border: Border.all(color: const Color(0xffDEDEDE)),
      ),
      child: Center(
        child: Text(
          "Verify",
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xffFFFFFF)),
        ),
      ),
    );
  }
}
