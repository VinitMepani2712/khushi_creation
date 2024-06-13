import 'package:flutter/material.dart';
import 'package:khushi_creation/widget/widget_support.dart';
import 'package:provider/provider.dart';
import 'package:khushi_creation/provider/profile_provider.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late ProfileProvider _profileProvider;

  @override
  void initState() {
    super.initState();
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    _profileProvider.getUserName();
    _profileProvider.getUserEmail();
    _profileProvider.getUserMobileNumber();
    _profileProvider.getUserGender();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () => profileProvider.pickImage(),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: profileProvider.image == null
                            ? AssetImage(profileProvider.photoURL)
                                as ImageProvider
                            : FileImage(profileProvider.image!),
                      ),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () => profileProvider.pickImage(),
                      child: Text(
                        'Change Profile Picture',
                        style: AppWidget.editProfileScreenStyle(),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(
                    indent: 5,
                    endIndent: 5,
                    color: const Color.fromARGB(255, 235, 234, 231),
                  ),
                  SizedBox(height: 10),
                  _buildProfileInfoSection(context, profileProvider),
                  SizedBox(height: 10),
                  Divider(
                    indent: 5,
                    endIndent: 5,
                    color: const Color.fromARGB(255, 235, 234, 231),
                  ),
                  SizedBox(height: 10),
                  _buildPersonalInfoSection(context, profileProvider),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileInfoSection(
      BuildContext context, ProfileProvider profileProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Profile Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ListTile(
          title: Text('Name'),
          subtitle: Text(profileProvider.name ?? ''),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildPersonalInfoSection(
      BuildContext context, ProfileProvider profileProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Personal Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ListTile(
          title: Text('User ID'),
          subtitle: Text(profileProvider.userId ?? ''),
          trailing: Icon(Icons.lock),
        ),
        ListTile(
          title: Text('E-mail'),
          subtitle: Text(profileProvider.email ?? ''),
        ),
        ListTile(
          title: Text('Phone Number'),
          subtitle: Text(profileProvider.phoneNumber ?? ''),
        ),
        ListTile(
          title: Text('Gender'),
          subtitle: Text(profileProvider.gender ?? ''),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) =>
                        _buildChangeEmailBottomSheet(context, profileProvider),
                  );
                },
                child: Text(
                  'Change Email',
                  style: AppWidget.editProfileScreenStyle(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChangeEmailBottomSheet(
      BuildContext context, ProfileProvider profileProvider) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Change Email',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(labelText: 'New Email'),
            onChanged: (value) {
              profileProvider.updateEmail(value);
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              profileProvider.updateEmail(profileProvider.email ?? '');
              Navigator.pop(context);
            },
            child: Text(
              'Update Email',
              style: AppWidget.editProfileScreenStyle(),
            ),
          ),
        ],
      ),
    );
  }
}
