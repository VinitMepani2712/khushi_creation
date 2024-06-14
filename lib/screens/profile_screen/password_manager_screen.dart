import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khushi_creation/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:khushi_creation/screens/auth/forgot_password_screen.dart';

class PasswordManagerScreen extends StatefulWidget {
  const PasswordManagerScreen({Key? key}) : super(key: key);

  @override
  State<PasswordManagerScreen> createState() => _PasswordManagerScreenState();
}

class _PasswordManagerScreenState extends State<PasswordManagerScreen> {
  bool isCurrentPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAppBar(context),
                      SizedBox(height: 20.h),
                      _buildLabel('Current Password'),
                      SizedBox(height: 10.h),
                      _buildPasswordField(
                        controller: currentPasswordController,
                        hintText: "Current Password",
                        isVisible: isCurrentPasswordVisible,
                        toggleVisibility: () => setState(() {
                          isCurrentPasswordVisible = !isCurrentPasswordVisible;
                        }),
                      ),
                      SizedBox(height: 10.h),
                      _buildForgotPasswordLink(),
                      SizedBox(height: 40.h),
                      _buildLabel('New Password'),
                      SizedBox(height: 10.h),
                      _buildPasswordField(
                        controller: newPasswordController,
                        hintText: "New Password",
                        isVisible: isNewPasswordVisible,
                        toggleVisibility: () => setState(() {
                          isNewPasswordVisible = !isNewPasswordVisible;
                        }),
                      ),
                      SizedBox(height: 20.h),
                      _buildLabel('Confirm New Password'),
                      SizedBox(height: 10.h),
                      _buildPasswordField(
                        controller: confirmPasswordController,
                        hintText: "Confirm New Password",
                        isVisible: isConfirmPasswordVisible,
                        toggleVisibility: () => setState(() {
                          isConfirmPasswordVisible = !isConfirmPasswordVisible;
                        }),
                        validator: (value) =>
                            value != newPasswordController.text
                                ? "Passwords do not match"
                                : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _buildSaveChangesButton(context),
          SizedBox(height: 10.h),
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
                "Password Manager",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16.sp),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool isVisible,
    required VoidCallback toggleVisibility,
    FormFieldValidator<String>? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: !isVisible,
      validator: validator ??
          (value) => value == null || value.isEmpty
              ? "Enter your password"
              : value.length < 8
                  ? "Password must be at least 8 characters long, \n1 Uppercase letter, \n1 Lowercase letter, \n1 Special Character"
                  : null,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(color: Color(0xffDEDEDE)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(color: Color(0xffDEDEDE)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(color: Color(0xffDEDEDE)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(color: Color(0xffDEDEDE)),
        ),
        fillColor: Color.fromRGBO(64, 123, 255, 0.03),
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Color(0xff858383)),
        suffixIcon: GestureDetector(
          onTap: toggleVisibility,
          child: Icon(
            isVisible ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
          ),
        ),
        border: InputBorder.none,
      ),
      style: TextStyle(color: Colors.black),
    );
  }

  Widget _buildForgotPasswordLink() {
    return GestureDetector(
      onTap: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ForgotPasswordScreen(),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          textAlign: TextAlign.end,
          'Forgot Password?',
          style: TextStyle(
            color: Color(0xff704F38),
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  Widget _buildSaveChangesButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          final profileProvider =
              Provider.of<ProfileProvider>(context, listen: false);

          try {
            await profileProvider.updatePassword(
              currentPasswordController.text,
              newPasswordController.text,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Password updated successfully')),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.toString())),
            );
          }
        }
      },
      child: Container(
        width: double.infinity,
        height: 54.h,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: Color(0xff704F38),
          border: Border.all(color: Color(0xffDEDEDE)),
        ),
        child: Center(
          child: Text(
            "SAVE CHANGES",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xffFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}
