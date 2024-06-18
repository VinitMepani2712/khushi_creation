import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khushi_creation/provider/address_proivder.dart';
import 'package:khushi_creation/provider/homes_screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final TextEditingController houseNumberController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController customAddressTypeController =
      TextEditingController();

  String _selectedAddressType = 'Home';

  @override
  void initState() {
    super.initState();
    _loadAddressData();
  }

  void _loadAddressData() {
    final addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    houseNumberController.text = addressProvider.houseNumber;
    streetController.text = addressProvider.street;
    areaController.text = addressProvider.area;
    pincodeController.text = addressProvider.pincode;
    cityController.text = addressProvider.city;
    stateController.text = addressProvider.state;
    countryController.text = addressProvider.country;
    mobileController.text = addressProvider.mobileNumber;
    _selectedAddressType = addressProvider.addressType;
    customAddressTypeController.text = addressProvider.customAddressType ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Address'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAddNewAddressText(),
              SizedBox(height: 20.0),
              _buildAddressTypeDropdown(),
              SizedBox(height: 16.0),
              if (_selectedAddressType == 'Other')
                _buildCustomAddressTypeField(),
              SizedBox(height: 16.0),
              _buildHouseNumberField(),
              SizedBox(height: 12.0),
              _buildStreetField(),
              SizedBox(height: 12.0),
              _buildAreaField(),
              SizedBox(height: 12.0),
              _buildPincodeField(),
              SizedBox(height: 12.0),
              _buildCityField(),
              SizedBox(height: 12.0),
              _buildStateField(),
              SizedBox(height: 12.0),
              _buildCountryField(),
              SizedBox(height: 12.0),
              _buildMobileNumberField(),
              SizedBox(height: 24.0),
              _buildSaveAddressButton(),
            ],
          ),
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
          child: Consumer<AddressProvider>(
            builder: (context, addressProvider, _) =>
                DropdownButtonFormField<String>(
              value: _selectedAddressType,
              onChanged: (newValue) {
                setState(() {
                  _selectedAddressType = newValue!;
                });
                addressProvider.setAddressType(newValue!);
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
        ),
      ],
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

  Widget _buildCustomAddressTypeField() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Consumer<AddressProvider>(
        builder: (context, addressProvider, _) => TextField(
          controller: customAddressTypeController,
          onChanged: (value) {
            addressProvider.setCustomAddressType(value);
          },
          decoration: InputDecoration(
            labelText: 'Specify Address Type',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
            errorText: addressProvider.customAddressType,
          ),
        ),
      ),
    );
  }

  Widget _buildHouseNumberField() {
    return _buildTextFormField(
      controller: houseNumberController,
      label: 'House Number',
      icon: Icons.home,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'House number is required';
        }
        return null;
      },
    );
  }

  Widget _buildStreetField() {
    return _buildTextFormField(
      controller: streetController,
      label: 'Street',
      icon: Icons.location_city,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Street is required';
        }
        return null;
      },
    );
  }

  Widget _buildAreaField() {
    return _buildTextFormField(
      controller: areaController,
      label: 'Area',
      icon: Icons.place,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Area is required';
        }
        return null;
      },
    );
  }

  Widget _buildPincodeField() {
    return _buildTextFormField(
      controller: pincodeController,
      label: 'Pincode',
      icon: Icons.pin_drop,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Pincode is required';
        }
        return null;
      },
    );
  }

  Widget _buildCityField() {
    return _buildTextFormField(
      controller: cityController,
      label: 'City',
      icon: Icons.location_city,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'City is required';
        }
        return null;
      },
    );
  }

  Widget _buildStateField() {
    return _buildTextFormField(
      controller: stateController,
      label: 'State',
      icon: Icons.location_city,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'State is required';
        }
        return null;
      },
    );
  }

  Widget _buildCountryField() {
    return _buildTextFormField(
      controller: countryController,
      label: 'Country',
      icon: Icons.location_city,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Country is required';
        }
        return null;
      },
    );
  }

  Widget _buildMobileNumberField() {
    return _buildTextFormField(
      controller: mobileController,
      label: 'Mobile Number',
      icon: Icons.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Mobile number is required';
        }

        if (value.length != 10) {
          return 'Mobile number must be 10 digits long';
        }

        return null;
      },
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          onChanged: (value) {
            final addressProvider =
                Provider.of<AddressProvider>(context, listen: false);
            if (label == 'Mobile Number') {
              addressProvider.setMobileNumber(value);
            } else if (label == 'House Number') {
              addressProvider.setHouseNumber(value);
            } else if (label == 'Street') {
              addressProvider.setStreet(value);
            } else if (label == 'Area') {
              addressProvider.setArea(value);
            } else if (label == 'Pincode') {
              addressProvider.setPincode(value);
            } else if (label == 'City') {
              addressProvider.setCity(value);
            } else if (label == 'State') {
              addressProvider.setState(value);
            } else if (label == 'Country') {
              addressProvider.setCountry(value);
            }
          },
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon, color: Colors.brown),
            border: OutlineInputBorder(),
            errorText: validator != null ? validator(controller.text) : null,
          ),
          inputFormatters: inputFormatters,
          keyboardType: label == 'Mobile Number'
              ? TextInputType.phone
              : TextInputType.text,
        ),
        SizedBox(height: 6.0),
      ],
    );
  }

  Widget _buildSaveAddressButton() {
    return Consumer<AddressProvider>(
      builder: (context, addressProvider, _) => Center(
        child: ElevatedButton(
          onPressed: () {
            _saveAddress(context, addressProvider);
            clearControllers();
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
      ),
    );
  }

  void _saveAddress(
      BuildContext context, AddressProvider addressProvider) async {
    if (_validateFields()) {
      String addressType = _selectedAddressType == 'Other'
          ? customAddressTypeController.text
          : _selectedAddressType;

      String formattedAddress = '${addressProvider.houseNumber}, '
          '${addressProvider.street}, '
          '${addressProvider.area}, '
          '${addressProvider.pincode}, '
          '${addressProvider.city}, '
          '${addressProvider.state}, '
          '${addressProvider.country}';

      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .collection('addresses')
              .add({
            'addressType': addressType,
            'formattedAddress': formattedAddress,
            'mobileNumber': addressProvider.mobileNumber,
          });

          Provider.of<HomeProviderScreen>(context, listen: false)
              .setCurrentLocation(formattedAddress, addressType);
          clearControllers();
          Navigator.pop(context);
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
          message: 'Please fill in all fields.',
        ),
      );
    }
  }

  bool _validateFields() {
    return houseNumberController.text.isNotEmpty &&
        streetController.text.isNotEmpty &&
        areaController.text.isNotEmpty &&
        pincodeController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        stateController.text.isNotEmpty &&
        countryController.text.isNotEmpty &&
        mobileController.text.isNotEmpty &&
        (_selectedAddressType != 'Other' ||
            customAddressTypeController.text.isNotEmpty);
  }

  void clearControllers() {
    houseNumberController.clear();
    streetController.clear();
    areaController.clear();
    pincodeController.clear();
    cityController.clear();
    stateController.clear();
    countryController.clear();
    mobileController.clear();
    customAddressTypeController.clear();
    setState(() {
      _selectedAddressType = 'Home';
    });
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
