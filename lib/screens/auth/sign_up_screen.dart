import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khushi_creation/provider/auth_provider.dart';
import 'package:khushi_creation/screens/auth/sing_in_screen.dart';
import 'package:provider/provider.dart';
import 'package:khushi_creation/widget/widget_support.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          _buildTitle(),
                          SizedBox(height: 20.h),
                          _buildSubtitle(),
                          SizedBox(height: 50.h),
                          _buildNameField(authProvider),
                          SizedBox(height: 20.h),
                          _buildEmailField(authProvider),
                          SizedBox(height: 20.h),
                          _buildPasswordField(authProvider),
                          _buildCheckbox(authProvider),
                          _buildSignUpButton(authProvider, context),
                          Divider(
                            height: 40.h,
                            color: Color(0xffD1D3D4),
                            indent: 20.w,
                            endIndent: 20.w,
                          ),
                          _buildSocialIcons(authProvider, context),
                          SizedBox(height: 15.h),
                          _buildSignInText(context),
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
      "Create Account",
      textAlign: TextAlign.center,
      style: AppWidget.textStyle(),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      "Fill your information below or register \nwith your social account",
      textAlign: TextAlign.center,
      style: AppWidget.lightTextStyle(),
    );
  }

  Widget _buildNameField(AuthenticationProvider authprovider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Name"),
        SizedBox(height: 10.h),
        TextFormField(
          controller: authprovider.nameController,
          validator: (value) => value == null || value.isEmpty
              ? '\u274C Please enter your name'
              : null,
          decoration: _inputDecoration(
            hintText: "Name",
            icon: Icons.person,
          ),
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildEmailField(AuthenticationProvider authprovider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Email"),
        SizedBox(height: 10.h),
        TextFormField(
          controller: authprovider.emailController,
          onChanged: (value) => authprovider.setEmail(value),
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

  Widget _buildPasswordField(AuthenticationProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Password"),
        SizedBox(height: 10.h),
        TextFormField(
          controller: provider.passwordController,
          obscureText: !provider.isPasswordVisible,
          onChanged: (value) => provider.setPassword(value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "\u274C Enter your password";
            } else if (value.length < 8) {
              return "\u274C Password must be at least 8 characters long";
            } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
              return "\u274C Password must contain at least one \nuppercase letter";
            } else if (!RegExp(r'[a-z]').hasMatch(value)) {
              return "\u274C Password must contain at least one \nlowercase letter";
            } else if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
              return "\u274C Password must contain at least one \nspecial character";
            }
            return null;
          },
          decoration: _inputDecoration(
            hintText: "Password",
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

  Widget _buildCheckbox(AuthenticationProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          title: RichText(
            text: TextSpan(
              text: 'Agree with ',
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: 'Terms & Conditions',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color(0xff704F38)),
                ),
              ],
            ),
          ),
          value: provider.isChecked,
          onChanged: (newValue) {
            provider.setChecked(newValue ?? false);
          },
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: Color(0xff704F38),
          checkColor: Colors.white,
          checkboxShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        if (provider.showCheckboxError)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'You must agree to the Terms & Conditions',
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }

  Widget _buildSignUpButton(
      AuthenticationProvider authProvider, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          authProvider.setEmail(authProvider.emailController.text);
          authProvider.setPassword(authProvider.passwordController.text);
          authProvider.registration(context, authProvider.isChecked);
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        width: MediaQuery.of(context).size.width,
        height: 54.h,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color(0xff704F38),
          border: Border.all(color: const Color(0xffDEDEDE)),
        ),
        child: Center(
          child: authProvider.isSignIn
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Text(
                  "Sign Up",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xffFFFFFF)),
                ),
        ),
      ),
    );
  }

  Widget _buildSocialIcons(
      AuthenticationProvider provider, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSocialIcon('assets/svg/apple.svg', 20.0.w, 30.0.h, () {}),
        _buildSocialIcon(
          'assets/svg/google.svg',
          20.0.w,
          30.0.h,
          () {
            provider.signInWithGoogle(context);
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

  Widget _buildSignInText(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignInScreen(),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 18.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account?",
              style: TextStyle(
                color: Color(0xFF6C6C6C),
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
            ),
            Text(
              " Sign In",
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
