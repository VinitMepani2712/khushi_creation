import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khushi_creation/provider/homes_screen_provider.dart';
import 'package:khushi_creation/screens/check_out_screen/add_new_address_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddressSelectionScreen extends StatefulWidget {
  @override
  State<AddressSelectionScreen> createState() => _AddressSelectionScreenState();
}

class _AddressSelectionScreenState extends State<AddressSelectionScreen> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _getUser() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          _user = user;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Address'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_user != null) _buildSavedAddresses(context),
            _buildAddNewAddressButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAddNewAddressButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0.h),
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddAddressScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown,
            minimumSize: Size(MediaQuery.of(context).size.width / 1.2, 48.0),
          ),
          child: Text(
            'Add New Address',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildSavedAddresses(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(_user!.uid)
            .collection('addresses')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: ListTile(
                    onTap: () {
                      _setSelectedAddress(context, data);
                    },
                    leading: _buildAddressTypeIcon(
                      data['addressType'],
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['addressType'],
                        ),
                        Text(
                          data['formattedAddress'],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: const Color.fromARGB(255, 241, 147, 141),
                      ),
                      onPressed: () {
                        _deleteAddress(context, document.id);
                      },
                    ),
                  ),
                );
              },
            );
          }

          return Center(
            child: Text('No addresses found.'),
          );
        },
      ),
    );
  }

  Widget _buildAddressTypeIcon(String addressType) {
    IconData iconData;
    Color iconColor = Colors.brown;

    switch (addressType) {
      case 'Home':
        iconData = Icons.home;
        break;
      case 'Work':
        iconData = Icons.work;
        break;
      case 'Other':
        iconData = Icons.place;
        break;
      default:
        iconData = Icons.location_on;
    }

    return Icon(iconData, color: iconColor);
  }

  void _deleteAddress(BuildContext context, String documentId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this address?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(_user!.uid)
                      .collection('addresses')
                      .doc(documentId)
                      .delete();
                } catch (e) {
                  print('Error deleting address: $e');
                  showDialog(
                    context: context,
                    builder: (context) => _buildErrorDialog(
                      title: 'Error',
                      message:
                          'Failed to delete address. Please try again later.',
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _setSelectedAddress(BuildContext context, Map<String, dynamic> data) {
    try {
      final selectedAddressProvider =
          Provider.of<HomeProviderScreen>(context, listen: false);

      selectedAddressProvider.setCurrentLocation(
        data['formattedAddress'],
        data['addressType'],
      );

      Navigator.pop(context);
    } catch (e) {
      print('Error setting selected address: $e');
      showDialog(
        context: context,
        builder: (context) => _buildErrorDialog(
          title: 'Error',
          message: 'Failed to set selected address. Please try again later.',
        ),
      );
    }
  }

  Widget _buildErrorDialog({required String title, required String message}) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('OK'),
        ),
      ],
    );
  }
}
