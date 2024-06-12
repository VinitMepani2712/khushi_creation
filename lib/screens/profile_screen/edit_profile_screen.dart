import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:khushi_creation/provider/profile_provider.dart';

class EditProfileScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileProvider(),
      child: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          _emailController.text = profileProvider.email;

          return Scaffold(
            appBar: AppBar(
              title: Text('Profile'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => profileProvider.pickImage(),
                      child: CircleAvatar(
                        radius: 75,
                        backgroundImage: profileProvider.image == null
                            ? NetworkImage(profileProvider.photoURL)
                            : FileImage(profileProvider.image!)
                                as ImageProvider,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () =>
                            _showChangeEmailDialog(context, profileProvider),
                        child: Text('Change Email'),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: 'New Password'),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        await profileProvider.saveChanges(
                          _emailController.text,
                          _passwordController.text,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Changes saved')),
                        );
                      },
                      child: Text(
                        'Save Changes',
                        style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Color.fromARGB(255, 255, 255, 255)
                                  : Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showChangeEmailDialog(
      BuildContext context, ProfileProvider profileProvider) {
    final _newEmailController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Email'),
          content: TextField(
            controller: _newEmailController,
            decoration: InputDecoration(labelText: 'New Email'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                profileProvider.updateEmail(_newEmailController.text);
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
