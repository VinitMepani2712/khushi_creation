import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khushi_creation/screens/auth/forgot_password_screen.dart';
import 'package:khushi_creation/screens/auth/sign_up_screen.dart';
import 'package:khushi_creation/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:khushi_creation/widget/widget_support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String email = "";
  String password = "";
  bool isPasswordVisible1 = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoggingIn = false;

  Future<void> userSignIn() async {
    setState(() {
      _isLoggingIn = true;
    });

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavBar(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';

      if (e.code == 'user-not-found') {
        errorMessage = "User id is not registered";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Your password is wrong! Please try again";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.brown,
          content: Text(
            errorMessage,
            style: AppWidget.snackbarTextStyle(),
          ),
        ),
      );
    } finally {
      setState(() {
        _isLoggingIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 40.h),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                children: [
                  _buildTitle(),
                  SizedBox(height: 20.h),
                  _buildSubtitle(),
                  SizedBox(height: 40.h),
                  _buildEmailField(),
                  SizedBox(height: 20.h),
                  _buildPasswordField(),
                  SizedBox(height: 10.h),
                  _buildForgotPassword(),
                  SizedBox(height: 10.h),
                  _buildSignInButton(),
                  Divider(
                    height: 40.h,
                    color: Color(0xffD1D3D4),
                    indent: 20.w,
                    endIndent: 20.w,
                  ),
                  _buildSocialIcons(),
                  SizedBox(height: 15.h),
                  _buildSignUpText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Sign In',
      textAlign: TextAlign.center,
      style: AppWidget.textStyle(),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      "Hi! Welcome back, you've been missed",
      textAlign: TextAlign.center,
      style: AppWidget.lightTextStyle(),
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email'),
        SizedBox(height: 10.h),
        TextFormField(
          controller: emailController,
          validator: (value) => value == null || value.isEmpty
              ? '\u274C Please enter your email address'
              : !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)
                  ? '\u274C Please enter a valid email address'
                  : null,
          decoration: _inputDecoration(
            hintText: 'Email',
            icon: FontAwesomeIcons.envelope,
          ),
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Password'),
        SizedBox(height: 10.h),
        TextFormField(
          controller: passwordController,
          obscureText: !isPasswordVisible1,
          validator: (value) => value == null || value.isEmpty
              ? '\u274C Please Enter Password'
              : null,
          decoration: _inputDecoration(
            hintText: 'Password',
            icon: isPasswordVisible1
                ? FontAwesomeIcons.eye
                : FontAwesomeIcons.eyeSlash,
            onIconTap: () => setState(() {
              isPasswordVisible1 = !isPasswordVisible1;
            }),
          ),
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildForgotPassword() {
    return Padding(
      padding: EdgeInsets.only(left: 180.w),
      child: TextButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ForgotPasswordScreen(),
          ),
        ),
        child: Text(
          'Forgot Password?',
          textAlign: TextAlign.end,
          style: TextStyle(
            color: Color(0xff704F38),
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return GestureDetector(
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          setState(() {
            email = emailController.text;
            password = passwordController.text;
          });

          await userSignIn();
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 54.h,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color(0xff704F38),
          border: Border.all(color: const Color(0xffDEDEDE)),
        ),
        child: Center(
          child: _isLoggingIn
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Text(
                  'Sign In',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xffFFFFFF)),
                ),
        ),
      ),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSocialIcon(
          'assets/svg/apple.svg',
          20.0.w,
          30.0.h,
        ),
        _buildSocialIcon(
          'assets/svg/google.svg',
          20.0.w,
          30.0.h,
        ),
        _buildSocialIcon(
          'assets/svg/facebook.svg',
          20.0.w,
          30.0.h,
        ),
      ],
    );
  }

  Widget _buildSocialIcon(String assetName, double width, double height) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(100),
      ),
      child: CircleAvatar(
        minRadius: 25,
        maxRadius: 25,
        backgroundColor: Colors.transparent,
        child: SvgPicture.asset(
          assetName,
          width: width,
          height: height,
        ),
      ),
    );
  }

  Widget _buildSignUpText() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignUpScreen(),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 18.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account?",
              style: TextStyle(
                color: Color(0xFF6C6C6C),
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
            ),
            Text(
              ' Sign Up',
              style: TextStyle(
                color: Color(0xff704F38),
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
              ),
            ),
          ],
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
          color: Color((0xffDEDEDE)),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(
          color: Color((0xffDEDEDE)),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(
          color: Color((0xffDEDEDE)),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(
          color: Color((0xffDEDEDE)),
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
