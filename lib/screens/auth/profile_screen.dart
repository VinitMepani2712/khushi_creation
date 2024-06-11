import 'package:khushi_creation/widget/widget_support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class ComplatedProfileScreen extends StatefulWidget {
  const ComplatedProfileScreen({super.key});

  @override
  State<ComplatedProfileScreen> createState() => _ComplatedProfileScreenState();
}

class _ComplatedProfileScreenState extends State<ComplatedProfileScreen> {
  final _formkey = GlobalKey<FormState>();
  String? _selectedGender;
  bool isChecked = false;
  String name = "";

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.only(top: 70.h, left: 20.w, right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(height: 40.h),
                Column(
                  children: [
                    Text(
                      "Complete Your Profile",
                      textAlign: TextAlign.center,
                      style: AppWidget.textStyle(),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                        " 'Don\'t worry, only you can see your personal data. No one else will be able to see it. "),
                  ],
                ),
                SizedBox(height: 50.h),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        minRadius: 75,
                        maxRadius: 75,
                      ),
                      Positioned(
                        bottom: -50,
                        right: 0,
                        top: 50,
                        child: CircleAvatar(
                          backgroundColor: Color(0xff704F38),
                          child: Icon(
                            FontAwesomeIcons.penToSquare,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Text("Name"),
                SizedBox(height: 10.h),
                TextFormField(
                  controller: nameController,
                  validator: (value) => value == null || value.isEmpty
                      ? '\u274C Please enter your name'
                      : null,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                        color: Color(
                          (0xffDEDEDE),
                        ),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                        color: Color(
                          (0xffDEDEDE),
                        ),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                        color: Color(
                          (0xffDEDEDE),
                        ),
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                        color: Color(
                          (0xffDEDEDE),
                        ),
                      ),
                    ),
                    fillColor: Color.fromRGBO(64, 123, 255, 0.03),
                    filled: true,
                    hintText: "Name",
                    hintStyle: TextStyle(color: Color(0xff858383)),
                    suffixIcon: Icon(Icons.person),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 10.h),
                Text("Phone Number"),
                SizedBox(height: 10.h),
                IntlPhoneField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    fillColor: Color.fromRGBO(64, 123, 255, 0.03),
                    filled: true,
                    hintText: "Phone number",
                    hintStyle: TextStyle(color: Color(0xff858383)),
                    suffixIcon: Icon(Icons.phone),
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
                  ),
                  initialCountryCode: 'US',
                  onChanged: (phone) {
                    phoneController.text = phone.completeNumber;
                  },
                  validator: (phone) {
                    if (phone == null || phone.number.isEmpty) {
                      return '\u274C Please enter your number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.h),
                Text("Gender"),
                SizedBox(height: 10.h),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                        color: Color(
                          (0xffDEDEDE),
                        ),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                        color: Color(
                          (0xffDEDEDE),
                        ),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                        color: Color(
                          (0xffDEDEDE),
                        ),
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                        color: Color(
                          (0xffDEDEDE),
                        ),
                      ),
                    ),
                    fillColor: Color.fromRGBO(64, 123, 255, 0.03),
                    filled: true,
                  ),
                  value: _selectedGender,
                  items: ['Select', 'Male', 'Female', 'Other']
                      .map((gender) => DropdownMenuItem<String>(
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value == 'Select') {
                      return 'Please select your gender';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40.h),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
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
                      child: Text(
                        "Complete Profile",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xffFFFFFF)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
