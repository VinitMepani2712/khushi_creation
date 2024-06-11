import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khushi_creation/header/header_widget.dart';
import 'package:khushi_creation/widget/widget_support.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  String email = "";

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password Reset mail has been sent"),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No User Found for that Email"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderWidget(
        title: 'Forgot Password',
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 70.h, left: 20.w, right: 20.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTitleSection(),
                SizedBox(height: 40.h),
                _buildEmailField(),
                SizedBox(height: 30.h),
                _buildSendPasswordLink(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "New Password",
          textAlign: TextAlign.center,
          style: AppWidget.textStyle(),
        ),
        SizedBox(height: 20.h),
        Text(
          "Your password must be different \nfrom previously used passwords",
          textAlign: TextAlign.center,
          style: AppWidget.lightTextStyle(),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Email"),
        SizedBox(height: 10.h),
        TextFormField(
          controller: emailController,
          validator: (value) => value == null || value.isEmpty
              ? '\u274C Please enter your email address'
              : !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)
                  ? '\u274C Please enter a valid email address'
                  : null,
          decoration: _inputDecoration(
            hintText: "Email",        
            icon: FontAwesomeIcons.envelope,
          ),
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildSendPasswordLink(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          setState(() {
            email = emailController.text;
          });
          resetPassword();
        }
      },
      child: Container(
        width: 320.w,
        height: 54.h,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          color: Color(0xff704F38),
          border: Border.all(color: Color(0xffDEDEDE)),
        ),
        child: Center(
          child: Text(
            "Send Password Link",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(
      {required String hintText,
      required IconData icon,
      VoidCallback? onIconTap}) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(
          color: Color(
            (0xffDEDEDE),
          ),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(
          color: Color(
            (0xffDEDEDE),
          ),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(
          color: Color(
            (0xffDEDEDE),
          ),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(
          color: Color(
            (0xffDEDEDE),
          ),
        ),
      ),
      fillColor: Color.fromRGBO(64, 123, 255, 0.03),
      filled: true,
      hintText: hintText,
      hintStyle: TextStyle(color: Color(0xff858383)),
      suffixIcon: GestureDetector(
        onTap: onIconTap,
        child: Icon(icon),
      ),
      border: InputBorder.none,
    );
  }
}
