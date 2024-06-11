import 'package:khushi_creation/screens/auth/sing_in_screen.dart';
import 'package:khushi_creation/screens/on_board_screen/on_board_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildHeaderImages(),
            buildBottom(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeaderImages() {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 40.h),
      child: Column(
        children: [
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 160.w,
                height: 400.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.h),
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/welcome_screen/left_side.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                children: [
                  Container(
                    width: 140.w,
                    height: 220.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.h),
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/welcome_screen/right_top.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  CircleAvatar(
                    radius: 80.r,
                    backgroundImage: AssetImage(
                        'assets/images/welcome_screen/right_bottom.jpeg'),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 40.h),
          Text.rich(
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
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget buildBottom(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
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
          ElevatedButton(
            onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => OnBoardScreen())),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              padding: EdgeInsets.symmetric(horizontal: 100.w, vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            child: Text(
              "Let's Get Started",
              style: TextStyle(fontSize: 18.sp, color: Color(0xffFFFFFF)),
            ),
          ),
          SizedBox(height: 16.h),
          TextButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SignInScreen(),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color.fromARGB(255, 0, 0, 0)),
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
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
