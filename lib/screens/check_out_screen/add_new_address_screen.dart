// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/services.dart';
// import 'package:khushi_creation/provider/address_proivder.dart';
// import 'package:provider/provider.dart';

// class AddNewAddressScreen extends StatefulWidget {
//   @override
//   State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
// }

// class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _customAddressTypeController =
//       TextEditingController();
//   final TextEditingController _streetController = TextEditingController();
//   final TextEditingController _areaController = TextEditingController();
//   final TextEditingController _pincodeController = TextEditingController();
//   final TextEditingController _cityController = TextEditingController();
//   final TextEditingController _stateController = TextEditingController();
//   final TextEditingController _mobileNumberController = TextEditingController();

//   String _selectedAddressType = 'Home';
//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     var addressProvider = Provider.of<AddressProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add New Address'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Add a New Address',
//                   style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 20.0),
//                 _buildAddressTypeDropdown(),
//                 if (_selectedAddressType == 'Other')
//                   _buildCustomAddressTypeField(),
//                 SizedBox(height: 16.0),
//                 _buildAddressTextField(),
//                 SizedBox(height: 24.0),
//                 _buildSaveAddressButton(context),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAddressTypeDropdown() {
//     return DropdownButtonFormField<String>(
//       value: _selectedAddressType,
//       onChanged: (newValue) {
//         setState(() {
//           _selectedAddressType = newValue!;
//           Provider.of<AddressProvider>(context, listen: false)
//               .setAddressType(newValue); // Update address type in provider
//         });
//       },
//       items: ['Home', 'Work', 'Other']
//           .map((type) => DropdownMenuItem(
//                 value: type,
//                 child: Text(type),
//               ))
//           .toList(),
//       decoration: InputDecoration(
//         labelText: 'Address Type',
//         border: OutlineInputBorder(),
//         contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please select an address type';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildCustomAddressTypeField() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 16.0),
//       child: TextFormField(
//         controller: _customAddressTypeController,
//         decoration: InputDecoration(
//           labelText: 'Specify Address Type',
//           border: OutlineInputBorder(),
//           contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
//         ),
//         validator: (value) {
//           if (_selectedAddressType == 'Other' &&
//               (value == null || value.isEmpty)) {
//             return 'Please specify the address type';
//           }
//           return null;
//         },
//         onChanged: (value) {
//           Provider.of<AddressProvider>(context, listen: false)
//               .setCustomAddressType(
//                   value); // Update custom address type in provider
//         },
//       ),
//     );
//   }

//   Widget _buildAddressTextField() {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextFormField(
//             controller: _addressController,
//             decoration: InputDecoration(
//               labelText: 'House Number',
//               prefixIcon: Icon(Icons.home),
//               border: OutlineInputBorder(),
//               contentPadding:
//                   EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter the house number';
//               }
//               return null;
//             },
//             onChanged: (value) {
//               Provider.of<AddressProvider>(context, listen: false)
//                   .setHouseNumber(value); // Update house number in provider
//             },
//           ),
//           SizedBox(height: 12.0),
//           TextFormField(
//             controller: _streetController,
//             decoration: InputDecoration(
//               labelText: 'Street',
//               prefixIcon: Icon(Icons.streetview),
//               border: OutlineInputBorder(),
//               contentPadding:
//                   EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter the street';
//               }
//               return null;
//             },
//             onChanged: (value) {
//               Provider.of<AddressProvider>(context, listen: false)
//                   .setStreet(value); // Update street in provider
//             },
//           ),
//           SizedBox(height: 12.0),
//           TextFormField(
//             controller: _areaController,
//             decoration: InputDecoration(
//               labelText: 'Area',
//               prefixIcon: Icon(Icons.location_city),
//               border: OutlineInputBorder(),
//               contentPadding:
//                   EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter the area';
//               }
//               return null;
//             },
//             onChanged: (value) {
//               Provider.of<AddressProvider>(context, listen: false)
//                   .setArea(value); // Update area in provider
//             },
//           ),
//           SizedBox(height: 12.0),
//           TextFormField(
//             controller: _pincodeController,
//             decoration: InputDecoration(
//               labelText: 'Pincode',
//               prefixIcon: Icon(Icons.pin_drop),
//               border: OutlineInputBorder(),
//               contentPadding:
//                   EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter the pincode';
//               }
//               return null;
//             },
//             onChanged: (value) {
//               Provider.of<AddressProvider>(context, listen: false)
//                   .setPincode(value); // Update pincode in provider
//             },
//           ),
//           SizedBox(height: 12.0),
//           TextFormField(
//             controller: _cityController,
//             decoration: InputDecoration(
//               labelText: 'City',
//               prefixIcon: Icon(Icons.location_city),
//               border: OutlineInputBorder(),
//               contentPadding:
//                   EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter the city';
//               }
//               return null;
//             },
//             onChanged: (value) {
//               Provider.of<AddressProvider>(context, listen: false)
//                   .setCity(value); // Update city in provider
//             },
//           ),
//           SizedBox(height: 12.0),
//           TextFormField(
//             controller: _stateController,
//             decoration: InputDecoration(
//               labelText: 'State',
//               prefixIcon: Icon(Icons.location_city),
//               border: OutlineInputBorder(),
//               contentPadding:
//                   EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter the state';
//               }
//               return null;
//             },
//             onChanged: (value) {
//               Provider.of<AddressProvider>(context, listen: false)
//                   .setState(value); 
//             },
//           ),
//           SizedBox(height: 12.0),
//           TextFormField(
//             controller: _mobileNumberController,
//             decoration: InputDecoration(
//               labelText: 'Mobile Number',
//               prefixIcon: Icon(Icons.phone),
//               border: OutlineInputBorder(),
//               contentPadding:
//                   EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
//             ),
//             keyboardType:
//                 TextInputType.numberWithOptions(decimal: false, signed: false),
//             inputFormatters: [
//               FilteringTextInputFormatter.digitsOnly,
//               LengthLimitingTextInputFormatter(10),
//             ],
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter the mobile number';
//               }
//               return null;
//             },
//             onChanged: (value) {
//               Provider.of<AddressProvider>(context, listen: false)
//                   .setMobileNumber(value);
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSaveAddressButton(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         if (_formKey.currentState!.validate()) {
         
//           String fullAddress =
//               Provider.of<AddressProvider>(context, listen: false).fullAddress;

        
//           FirebaseFirestore.instance.collection('addresses').add({
//             'fullAddress': fullAddress,
//             'addressType': Provider.of<AddressProvider>(context, listen: false)
//                 .addressType,
//             'customAddressType':
//                 Provider.of<AddressProvider>(context, listen: false)
//                     .customAddressType,
//           }).then((_) {
//             // Show success message or navigate to another screen
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               content: Text('Address added successfully!'),
//             ));
//           }).catchError((error) {
//             // Handle error
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               content: Text('Failed to add address: $error'),
//             ));
//           });
//         }
//       },
//       child: Text('Save Address'),
//     );
//   }
// }
