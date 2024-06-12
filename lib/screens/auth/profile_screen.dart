import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:khushi_creation/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:khushi_creation/provider/profile_provider.dart';
import 'package:khushi_creation/widget/widget_support.dart';

class ComplatedProfileScreen extends StatefulWidget {
  const ComplatedProfileScreen({super.key});

  @override
  State<ComplatedProfileScreen> createState() => _ComplatedProfileScreenState();
}

class _ComplatedProfileScreenState extends State<ComplatedProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedGender;
  bool isChecked = false;
  String? _name;
  String? _phoneNumber;
  bool _isLoading = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

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
                _buildTextField(
                  label: "Name",
                  controller: nameController,
                  hintText: "Name",
                  icon: Icons.person,
                  validator: (value) => value == null || value.isEmpty
                      ? '\u274C Please enter your name'
                      : null,
                ),
                SizedBox(height: 10.h),
                _buildPhoneField(),
                SizedBox(height: 10.h),
                _buildGenderDropdown(),
                SizedBox(height: 40.h),
                _buildCompleteProfileButton(profileProvider),
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
          style: AppWidget.textStyle(),
        ),
        SizedBox(height: 20.h),
        Text(
            " 'Don't worry, only you can see your personal data. No one else will be able to see it. "),
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
                  FontAwesomeIcons.penToSquare,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 10.h),
        TextFormField(
          controller: controller,
          validator: validator,
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
            hintText: hintText,
            hintStyle: TextStyle(color: Color(0xff858383)),
            suffixIcon: Icon(icon),
            border: InputBorder.none,
          ),
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Phone Number"),
        SizedBox(height: 10.h),
        IntlPhoneField(
          initialValue: _phoneNumber,
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
          initialCountryCode: 'IND',
          onChanged: (phone) {
            setState(() {
              _phoneNumber = phone.completeNumber;
            });
          },
          validator: (phone) {
            if (phone == null || phone.number.isEmpty) {
              return '\u274C Please enter your number';
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
            'Select',
            'Male',
            'Female',
          ]
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
      ],
    );
  }

 Widget _buildCompleteProfileButton(ProfileProvider profileProvider) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
        onTap: () async {
          setState(() {
            _isLoading =
                true; 
          });
          if (_formKey.currentState!.validate()) {
            try {
              profileProvider.updatePhoneNumber(phoneController.text);
              profileProvider.updateGender(_selectedGender ?? '');
              await profileProvider.updateProfile();
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
                _isLoading =
                    false; 
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
            child: _isLoading // Check loading state to show appropriate content
                ? CircularProgressIndicator() // Show loading indicator if isLoading is true
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



