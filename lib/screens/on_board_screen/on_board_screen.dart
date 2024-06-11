import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khushi_creation/model/unborading_content_model.dart';
import 'package:khushi_creation/screens/auth/sign_up_screen.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        contents.length,
        (index) => AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          height: 10.h,
          width: currentIndex == index ? 20.w : 10.w,
          decoration: BoxDecoration(
            color: currentIndex == index ? Color(0xff704F38) : Colors.grey,
            borderRadius: BorderRadius.circular(5.w),
          ),
        ),
      ),
    );
  }

  Widget buildSkipButton() {
    return Positioned(
      top: 45.h,
      right: 20.w,
      child: GestureDetector(
        onTap: () {
          _controller.jumpToPage(contents.length - 1);
        },
        child: Center(
          child: Text(
            "SKIP",
            style: TextStyle(
              color: Color(0xff704F38),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildArrowButton(IconData icon, Function() onPressed) {
    return IconButton(
      icon: CircleAvatar(
        minRadius: 20,
        maxRadius: 20,
        backgroundColor: Color(0xff704F38),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      onPressed: onPressed,
    );
  }

  Widget buildForwardButton() {
    return IconButton(
      icon: CircleAvatar(
        minRadius: 22,
        maxRadius: 22,
        backgroundColor: Color(0xff704F38),
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
      onPressed: () {
        _controller.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
    );
  }

  Widget buildContent(BuildContext context, int index) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: Image.asset(
          contents[index].image,
          height: MediaQuery.of(context).size.height.h,
          width: MediaQuery.of(context).size.width / 1.3.w,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget buildActionButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (currentIndex != 0)
          buildArrowButton(Icons.arrow_back, () {
            _controller.previousPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          })
        else
          SizedBox(width: 48.w), 
        Spacer(), 
        buildDots(),
        Spacer(), 
        if (currentIndex == contents.length - 1)
          GestureDetector(
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SignUpScreen(),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              height: 30.h,
              width: MediaQuery.of(context).size.width / 3.w,
              decoration: BoxDecoration(
                  color: Color(0xff704F38),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                "Sign In Now",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        else
          buildForwardButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: contents.length,
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, i) {
              return buildContent(context, i);
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 3.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.w),
                  topRight: Radius.circular(30.w),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    contents[currentIndex].title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    contents[currentIndex].description,
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20.h,
            left: 20.w,
            right: 20.w,
            child: buildActionButton(context),
          ),
          if (currentIndex != contents.length - 1) buildSkipButton(),
        ],
      ),
    );
  }
}
