import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ManualLocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 70.h, left: 20.w, right: 20.w),
        child: Column(
          children: [
            buildHeader(context),
            SizedBox(height: 20.h),
            buildSearchField(),
            buildLocationOptions(),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
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
        ),
        SizedBox(width: MediaQuery.of(context).size.width / 7.w),
        Text(
          "Enter Your Location",
          style: TextStyle(fontSize: 18.sp),
        ),
      ],
    );
  }

  Widget buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
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
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              color: Color(0xffDEDEDE),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              color: Color(0xffDEDEDE),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              color: Color(0xffDEDEDE),
            ),
          ),
          prefixIcon: CircleAvatar(
            minRadius: 25,
            maxRadius: 25,
            backgroundColor: Colors.transparent,
            child: SvgPicture.asset(
              "assets/svg/search-normal-1.svg",
              color: Color(0xff704F38),
            ),
          ),
          suffixIcon: Icon(
            FontAwesomeIcons.circleXmark,
            color: Color(0xff704F38),
          ),
          hintText: 'Search',
          hintStyle: TextStyle(color: const Color.fromARGB(255, 199, 199, 199)),
        ),
      ),
    );
  }

  Widget buildLocationOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(FontAwesomeIcons.locationArrow, color: Colors.brown),
          title: Text('Use my current location',
              style: TextStyle(color: Colors.brown)),
          onTap: () {},
        ),
        Divider(),
        Text('SEARCH RESULT',
            style: TextStyle(fontSize: 12, color: Colors.grey)),
        ListTile(
          leading: Icon(FontAwesomeIcons.locationArrow, color: Colors.brown),
          title: Text('Golden Avenue'),
          subtitle: Text('8502 Preston Rd. Ingl..'),
          onTap: () {
            // Handle search result tap
          },
        ),
      ],
    );
  }
}
