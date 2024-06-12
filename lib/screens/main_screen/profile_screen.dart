import 'package:firebase_auth/firebase_auth.dart';
import 'package:khushi_creation/screens/auth/sing_in_screen.dart';
import 'package:khushi_creation/screens/profile_screen/edit_profile_screen.dart';
import 'package:khushi_creation/screens/profile_screen/help_center_screen.dart';
import 'package:khushi_creation/screens/profile_screen/invite_friend_screen.dart';
import 'package:khushi_creation/screens/profile_screen/payment_screen.dart';
import 'package:khushi_creation/screens/profile_screen/privacy_policy_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../profile_screen/setting_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        children: [
          SizedBox(height: 20),
          _buildProfileHeader(),
          SizedBox(height: 10),
          Center(
            child: Text(
              'Vinit Mepani',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
          _buildMenuItems(context),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      title: Padding(
        padding: EdgeInsets.only(left: 20.0.w, top: 40.0.h, right: 20.0.w),
        child: Text(
          textAlign: TextAlign.center,
          "Profile",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: CircleAvatar(
            radius: 55,
            backgroundImage:
                AssetImage('assets/images/welcome_screen/left_side.jpg'),
          ),
        ),
        Positioned(
          top: 75,
          left: 180,
          child: CircleAvatar(
            backgroundColor: Color(0xff704F38),
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80.0),
      child: Column(
        children: [
          ProfileMenuItem(
            icon: Icons.person,
            text: 'Your profile',
            isLastItem: false,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => EditProfileScreen()),
              ),
            ),
          ),
          ProfileMenuItem(
            icon: Icons.payment,
            text: 'Payment Methods',
            isLastItem: false,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => PaymentScreen()),
              ),
            ),
          ),
          ProfileMenuItem(
            icon: Icons.shopping_bag,
            text: 'My Orders',
            isLastItem: false,
          ),
          ProfileMenuItem(
            icon: Icons.settings,
            text: 'Settings',
            isLastItem: false,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => SettingScreen()),
              ),
            ),
          ),
          ProfileMenuItem(
            icon: Icons.help,
            text: 'Help Center',
            isLastItem: false,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => HelpCenterScreen()),
              ),
            ),
          ),
          ProfileMenuItem(
            icon: Icons.privacy_tip,
            text: 'Privacy Policy',
            isLastItem: false,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => PrivacyPolicyScreen()),
              ),
            ),
          ),
          ProfileMenuItem(
            icon: Icons.person_add,
            text: 'Invites Friends',
            isLastItem: false,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => InviteFriendsScreen()),
              ),
            ),
          ),
          ProfileMenuItem(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Logout",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w700),
                        ),
                        Divider(
                          thickness: 2,
                          indent: 20,
                          endIndent: 20,
                        ),
                        Text(
                          "Are you sure you want to logout?",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff726E6E)),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 40,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Color(0xff704F38), width: 2.0),
                                ),
                                child: Center(
                                  child: Text("Cancel"),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await FirebaseAuth.instance.signOut();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignInScreen(),
                                  ),
                                  (Route<dynamic> route) => false,
                                );
                              },
                              child: Container(
                                height: 40,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color(0xff704F38),
                                ),
                                child: Center(
                                  child: Text("Yes, Logout",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            },
            icon: Icons.logout,
            text: 'Log out',
            isLastItem: false,
          )
        ],
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isLastItem;
  final VoidCallback? onTap;

  ProfileMenuItem({
    required this.icon,
    required this.text,
    required this.isLastItem,
    this.onTap,
  });

  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.brown),
          title: Text(text),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.brown),
          onTap: onTap,
        ),
        if (!isLastItem)
          Divider(
            color: Colors.grey[300],
            thickness: 2,
          ),
      ],
    );
  }
}
