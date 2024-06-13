import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:khushi_creation/provider/auth_provider.dart';
import 'package:khushi_creation/provider/profile_provider.dart';
import 'package:khushi_creation/screens/bottom_nav_bar/bottom_nav_bar.dart';

class ComplatedProfileScreen extends StatefulWidget {
  const ComplatedProfileScreen({Key? key}) : super(key: key);

  @override
  State<ComplatedProfileScreen> createState() => _ComplatedProfileScreenState();
}

class _ComplatedProfileScreenState extends State<ComplatedProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedGender;
  String? _name;
  String? _phoneNumber;
  bool _isLoading = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final authProvider = Provider.of<AuthenticationProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(top: 70.h, left: 20.w, right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBackButton(context),
                SizedBox(height: 40.h),
                _buildHeader(),
                SizedBox(height: 50.h),
                _buildProfileImage(profileProvider),
                SizedBox(height: 20.h),
                _buildTextField(authProvider),
                SizedBox(height: 10.h),
                _buildPhoneField(),
                SizedBox(height: 10.h),
                _buildGenderDropdown(),
                SizedBox(height: 40.h),
                _buildCompleteProfileButton(authProvider),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
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
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          "Complete Your Profile",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20.h),
        Text(
          "Don't worry, only you can see your personal data. No one else will be able to see it.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.sp),
        ),
      ],
    );
  }

  Widget _buildProfileImage(ProfileProvider profileProvider) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            minRadius: 75,
            maxRadius: 75,
            backgroundImage: profileProvider.image == null
                ? AssetImage(profileProvider.photoURL) as ImageProvider
                : FileImage(profileProvider.image!),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => profileProvider.pickImage(),
              child: CircleAvatar(
                backgroundColor: Color(0xff704F38),
                child: Icon(
                  FontAwesomeIcons.pen,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextField(AuthenticationProvider authProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Name"),
        SizedBox(height: 10.h),
        TextFormField(
          controller: nameController,
          validator: (value) =>
              value == null || value.isEmpty ? 'Please enter your name' : null,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Color(0xffDEDEDE)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Color(0xffDEDEDE)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Color(0xffDEDEDE)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Color(0xffDEDEDE)),
            ),
            fillColor: Color.fromRGBO(64, 123, 255, 0.03),
            filled: true,
            hintText: "Name",
            hintStyle: TextStyle(color: Color(0xff858383)),
            suffixIcon: Icon(Icons.person),
            border: InputBorder.none,
          ),
          style: TextStyle(color: Colors.black),
          onChanged: (value) {
            setState(() {
              _name = value;
            });
          },
        ),
        SizedBox(height: 20.h),
        ],
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Phone Number"),
        SizedBox(height: 10.0),
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
              borderSide: BorderSide(color: Color(0xffDEDEDE)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Color(0xffDEDEDE)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Color(0xffDEDEDE)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Color(0xffDEDEDE)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Color(0xffDEDEDE)),
            ),
          ),
          initialCountryCode: 'IN',
          onChanged: (phone) {
            setState(() {
              _phoneNumber = phone.completeNumber;
            });
          },
          validator: (phone) {
            if (phone == null || phone.number.isEmpty) {
              return 'Please enter your number';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Gender"),
        SizedBox(height: 10.h),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
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
          ),
          value: _selectedGender,
          items: [
            DropdownMenuItem(
              value: 'Select',
              child: Text('Select'),
            ),
            DropdownMenuItem(
              value: 'Male',
              child: Text('Male'),
            ),
            DropdownMenuItem(
              value: 'Female',
              child: Text('Female'),
            ),
          ],
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
      ],
    );
  }

  Widget _buildCompleteProfileButton(AuthenticationProvider authProvider) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            setState(() {
              _isLoading = true;
            });

            try {
              await authProvider.updateUserProfile(
                _name ?? '',
                _phoneNumber ?? '',
                _selectedGender ?? '',
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomNavBar(),
                ),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    "Error: $e",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            } finally {
              setState(() {
                _isLoading = false;
              });
            }
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
            child: _isLoading
                ? CircularProgressIndicator()
                : Text(
                    "Complete Profile",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xffFFFFFF)),
                  ),
          ),
        ),
      ),
    );
  }
}
