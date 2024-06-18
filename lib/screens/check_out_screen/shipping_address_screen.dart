import 'package:flutter/material.dart';
import 'package:khushi_creation/provider/homes_screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddressSelectionScreen extends StatefulWidget {
  @override
  State<AddressSelectionScreen> createState() => _AddressSelectionScreenState();
}

class _AddressSelectionScreenState extends State<AddressSelectionScreen> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _customAddressTypeController =
      TextEditingController();

  String _selectedAddressType = 'Home';
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAddNewAddressText(),
            SizedBox(height: 20.0),
            _buildAddressTypeDropdown(),
            if (_selectedAddressType == 'Other') _buildCustomAddressTypeField(),
            SizedBox(height: 16.0),
            _buildAddressTextField(),
            SizedBox(height: 24.0),
            _buildSaveAddressButton(context),
            SizedBox(height: 20.0),
            if (_user != null) _buildSavedAddresses(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAddNewAddressText() {
    return Text(
      'Add a New Address',
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildAddressTypeDropdown() {
    return Row(
      children: [
        _buildAddressTypeIconWidget(),
        SizedBox(width: 12.0),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: _selectedAddressType,
            onChanged: (newValue) {
              setState(() {
                _selectedAddressType = newValue!;
              });
            },
            items: ['Home', 'Work', 'Other']
                .map((type) => DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    ))
                .toList(),
            decoration: InputDecoration(
              labelText: 'Address Type',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomAddressTypeField() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: TextField(
        controller: _customAddressTypeController,
        decoration: InputDecoration(
          labelText: 'Specify Address Type',
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
        ),
      ),
    );
  }

  Widget _buildAddressTypeIconWidget() {
    IconData iconData;
    Color iconColor = Colors.brown;

    switch (_selectedAddressType) {
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

  Widget _buildAddressTextField() {
    return TextField(
      controller: _addressController,
      decoration: InputDecoration(
        labelText: 'Enter Address',
        prefixIcon: Icon(Icons.location_city, color: Colors.brown),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
      ),
      maxLines: 2,
    );
  }

  Widget _buildSaveAddressButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _saveAddress(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.brown,
          minimumSize: Size(MediaQuery.of(context).size.width / 1.2, 48.0),
        ),
        child: Text(
          'Save Address',
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
      ),
    );
  }

  void _saveAddress(BuildContext context) async {
    if (_addressController.text.isNotEmpty) {
      String address = _addressController.text;
      String addressType = _selectedAddressType == 'Other'
          ? _customAddressTypeController.text
          : _selectedAddressType;

      try {
        if (_user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(_user!.uid)
              .collection('addresses')
              .add({
            'addressType': addressType,
            'address': address,
          });

          Provider.of<HomeProviderScreen>(context, listen: false)
              .setCurrentLocation(address, addressType);

          Navigator.pop(context);

          _addressController.clear();
          _customAddressTypeController.clear();
          setState(() {
            _selectedAddressType = 'Home';
          });
        }
      } catch (e) {
        print('Error saving address: $e');
        showDialog(
          context: context,
          builder: (context) => _buildErrorDialog(
            title: 'Error',
            message: 'Failed to save address. Please try again later.',
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => _buildErrorDialog(
          title: 'Error',
          message: 'Please enter an address.',
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
                          data['address'],
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
        data['address'],
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
}
