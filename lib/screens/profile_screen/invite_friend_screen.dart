import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:url_launcher/url_launcher.dart';

class InviteFriendsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildAppBar(context),
            _buildFriendListView(context),
          ],
        ),
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
                "Invite Friends",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFriendListView(BuildContext context) {
    return FutureBuilder(
      future: ContactsService.getContacts(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error loading contacts'),
          );
        } else if (snapshot.data == null) {
          return Center(
            child: Text('No contacts available'),
          );
        } else if (snapshot.data == null) {
          print('Snapshot data is null');
          return Center(
            child: Text('No contacts available'),
          );
        } else {
          Iterable<Contact> contacts = snapshot.data as Iterable<Contact>;
          return Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.separated(
              itemCount: contacts.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final Contact contact = contacts.elementAt(index);
                String phoneNumber = contact.phones!.isNotEmpty
                    ? contact.phones!.first.value!
                    : 'No phone number';
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/default_avatar.png'),
                  ),
                  title: Text(contact.displayName ?? 'No name'),
                  subtitle: Text(phoneNumber),
                  trailing: ElevatedButton(
                    onPressed: () {
                      _inviteContact(phoneNumber);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF704F38),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Invite',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  void _inviteContact(String phoneNumber) async {
    // You can replace 'sms' with 'whatsapp' for using WhatsApp
    String uri = 'sms:$phoneNumber?body=Check out this cool app!';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // Handle error
      print('Error launching SMS app');
    }
  }
}
