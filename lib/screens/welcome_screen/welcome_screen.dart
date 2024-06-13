import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khushi_creation/screens/auth/sing_in_screen.dart';
import 'package:khushi_creation/screens/on_board_screen/on_board_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderImages(),
            _buildBottomSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderImages() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
      child: Column(
        children: [
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildImageContainer(
                width: 160.w,
                height: 400.h,
                borderRadius: 100.h,
                imagePath: 'assets/images/welcome_screen/left_side.jpg',
              ),
              SizedBox(width: 8.w),
              Column(
                children: [
                  _buildImageContainer(
                    width: 140.w,
                    height: 220.h,
                    borderRadius: 100.h,
                    imagePath: 'assets/images/welcome_screen/right_top.jpg',
                  ),
                  SizedBox(height: 16.h),
                  CircleAvatar(
                    radius: 80.r,
                    backgroundImage: AssetImage(
                      'assets/images/welcome_screen/right_bottom.jpeg',
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 40.h),
          _buildRichText(),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildImageContainer({
    required double width,
    required double height,
    required double borderRadius,
    required String imagePath,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildRichText() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'The ',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: 'Fashion App ',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          TextSpan(
            text: 'That Makes You Look Your Best',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          _buildElevatedButton(context),
          SizedBox(height: 16.h),
          _buildSignInTextButton(context),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildElevatedButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnBoardScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.brown,
        padding: EdgeInsets.symmetric(horizontal: 100.w, vertical: 16.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
      child: Text(
        "Let's Get Started",
        style: TextStyle(fontSize: 18.sp, color: Colors.white),
      ),
    );
  }

  Widget _buildSignInTextButton(BuildContext context) {
    return TextButton(
      onPressed: () =>
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
        ),
     
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account?',
            style: TextStyle(fontSize: 16.sp, color: Colors.black),
          ),
          Text(
            ' Sign In',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.brown,
              decoration: TextDecoration.underline,
              decorationColor: Colors.brown,
            ),
          ),
        ],
      ),
    );
  }
}
