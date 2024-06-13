import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:khushi_creation/screens/auth/completed_profile_screen.dart';
import 'package:khushi_creation/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:khushi_creation/screens/location/manual_location_screen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String? currentLocation;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
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
              SizedBox(height: 20),
              if (currentLocation != null) Text(currentLocation!),
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
    return Center(
      child: GestureDetector(
        onTap: () async {
          await _getCurrentLocation();
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
          child: _isLoading
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Text(
                  'Allow Location Access',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
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

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });

    var permission = await Permission.location.request();
    if (permission.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);

        Placemark place = placemarks[0];

        setState(() {
          currentLocation =
              '${place.street}, ${place.name}, ${place.locality}-${place.postalCode}, ${place.administrativeArea}, ${place.country}.';
        });

        await saveLocationToFirestore(currentLocation!);

        await Future.delayed(
          Duration(milliseconds: 300),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ComplatedProfileScreen(),
          ),
        );
      } catch (e) {
        setState(() {
          currentLocation = 'Failed to get location: $e';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        currentLocation = 'Location permission denied';
        _isLoading = false;
      });
    }
  }

  Future<void> saveLocationToFirestore(String location) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({'location': location}, SetOptions(merge: true));
    }
  }
}
