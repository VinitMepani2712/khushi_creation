import 'package:flutter/material.dart';
import 'package:khushi_creation/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khushi_creation/screens/auth/forgot_password_screen.dart';
import 'package:khushi_creation/screens/auth/sign_up_screen.dart';
import 'package:khushi_creation/widget/widget_support.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
    final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);


    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => AuthenticationProvider(),
        child: Consumer<AuthenticationProvider>(
          builder: (context, authProvider, child) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
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
                          _buildEmailField(authProvider),
                          SizedBox(height: 20.h),
                          _buildPasswordField(authProvider),
                          SizedBox(height: 10.h),
                          _buildForgotPassword(context),
                          SizedBox(height: 10.h),
                          _buildSignInButton(authProvider, context),
                          Divider(
                            height: 40.h,
                            color: Color(0xffD1D3D4),
                            indent: 20.w,
                            endIndent: 20.w,
                          ),
                          _buildSocialIcons(authProvider, context),
                          SizedBox(height: 15.h),
                          _buildSignUpText(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
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

  Widget _buildEmailField(AuthenticationProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email'),
        SizedBox(height: 10.h),
        TextFormField(
          onChanged: (value) => provider.setEmail(value),
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

  Widget _buildPasswordField(AuthenticationProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Password'),
        SizedBox(height: 10.h),
        TextFormField(
          obscureText: !provider.isPasswordVisible,
          onChanged: (value) => provider.setPassword(value),
          validator: (value) => value == null || value.isEmpty
              ? '\u274C Please Enter Password'
              : null,
          decoration: _inputDecoration(
            hintText: 'Password',
            icon: provider.isPasswordVisible
                ? FontAwesomeIcons.eye
                : FontAwesomeIcons.eyeSlash,
            onIconTap: provider.togglePasswordVisibility,
          ),
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildForgotPassword(BuildContext context) {
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

Widget _buildSignInButton(
      AuthenticationProvider authProvider, BuildContext context) {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () async {
          if (Form.of(context).validate()) {
            await authProvider.userSignIn(context);
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
            child: authProvider.isLoggingIn
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
      ),
    );
  }
 
  Widget _buildSocialIcons(
      AuthenticationProvider authProvider, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSocialIcon('assets/svg/apple.svg', 20.0.w, 30.0.h, () {}),
        _buildSocialIcon(
          'assets/svg/google.svg',
          20.0.w,
          30.0.h,
          () {
            authProvider.logInWithGoogle(context);
          },
        ),
        _buildSocialIcon(
          'assets/svg/facebook.svg',
          20.0.w,
          30.0.h,
          () {},
        ),
      ],
    );
  }

  Widget _buildSocialIcon(
      String assetName, double width, double height, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }


  Widget _buildSignUpText(BuildContext context) {
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
