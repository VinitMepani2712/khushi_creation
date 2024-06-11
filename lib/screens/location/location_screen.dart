import 'package:khushi_creation/screens/location/manual_location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildLocationIcon(),
              SizedBox(height: 20),
              buildTitle(),
              SizedBox(height: 10),
              buildDescription(),
              SizedBox(height: 30),
              buildAllowLocationButton(context),
              SizedBox(height: 20),
              buildManualLocationButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLocationIcon() {
    return CircleAvatar(
      minRadius: 60,
      maxRadius: 60,
      backgroundColor: Colors.grey[200],
      child: Icon(
        Icons.location_pin,
        color: Color(0xff704F38),
        size: 50,
      ),
    );
  }

  Widget buildTitle() {
    return Text(
      'What is Your Location?',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildDescription() {
    return Text(
      'We need to know your location in order to suggest nearby services.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
    );
  }

  Widget buildAllowLocationButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add functionality for allowing location access
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 10.w, right: 10.w),
        width: MediaQuery.of(context).size.width / 0.5.w,
        height: 54.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color(0xff704F38),
          border: Border.all(color: const Color(0xffDEDEDE)),
        ),
        child: Text(
          'Allow Location Access',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildManualLocationButton(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ManualLocationScreen(),
        ),
      ),
      child: Text(
        'Enter Location Manually',
        style: TextStyle(
          fontSize: 16,
          color: Colors.brown,
        ),
      ),
    );
  }
}
