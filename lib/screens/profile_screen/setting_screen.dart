import 'package:khushi_creation/provider/profile_provider.dart';
import 'package:khushi_creation/screens/auth/sign_up_screen.dart';
import 'package:provider/provider.dart';
import 'package:khushi_creation/screens/profile_screen/password_manager_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        children: [
          _buildAppBar(context),
          SizedBox(height: 20),
          _buildMenuItems(context),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.0.w, top: 40.0.h, right: 20.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffE6E6E6),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: CircleAvatar(
                    minRadius: 20,
                    maxRadius: 20,
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.arrow_back,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 50.w),
              Text(
                "Settings",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
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
            text: 'Notification Settings',
            isLastItem: false,
          ),
          ProfileMenuItem(
            icon: Icons.key,
            text: 'Password Manager',
            isLastItem: false,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PasswordManagerScreen(),
              ),
            ),
          ),
          ProfileMenuItem(
            icon: Icons.delete,
            text: 'Delete Account',
            isLastItem: true,
            onTap: () => _confirmDeleteAccount(context),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteAccount(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Wrap(
            children: [
              ListTile(
                title: Center(
                  child: Text(
                    'Confirm Delete',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Are you sure you want to delete your account? This action cannot be undone.',
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration:
                          InputDecoration(labelText: 'Enter your password'),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        ElevatedButton(
                          child: Text('Delete'),
                          onPressed: () async {
                            try {
                              await Provider.of<ProfileProvider>(context,
                                      listen: false)
                                  .deleteAccount(passwordController.text);
                              Navigator.of(context).pop();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Failed to delete account: ${e.toString()}')));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Icon(icon, color: Colors.brown),
          title: Text(text),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.brown),
        ),
        if (!isLastItem)
          Divider(
            color: Colors.grey,
            thickness: 2,
          ),
      ],
    );
  }
}
