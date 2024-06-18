import 'package:flutter/material.dart';

class AddressProvider with ChangeNotifier {
  String houseNumber = '';
  String street = '';
  String area = '';
  String pincode = '';
  String city = '';
  String state = '';
  String country = '';
  String mobileNumber = '';
  String addressType = 'Home';
  String? customAddressType;
  String _errorMessage = '';

  

  void setCustomAddressType(String value) {
    customAddressType = value;
    if (value.isEmpty) {
      _errorMessage = 'Custom address type is required';
    } else {
      _errorMessage = '';
    }
    notifyListeners();
  }

  String get errorMessage => _errorMessage;

  void setHouseNumber(String value) {
    houseNumber = value;
    notifyListeners();
  }

  void setStreet(String value) {
    street = value;
    notifyListeners();
  }

  void setArea(String value) {
    area = value;
    notifyListeners();
  }

  void setPincode(String value) {
    pincode = value;
    notifyListeners();
  }

  void setCity(String value) {
    city = value;
    notifyListeners();
  }

  void setState(String value) {
    state = value;
    notifyListeners();
  }

  void setCountry(String value) {
    country = value;
    notifyListeners();
  }

  void setAddressType(String value) {
    addressType = value;
    notifyListeners();
  }

  void setMobileNumber(String value) {
    mobileNumber = value;
    notifyListeners();
  }

  String get address {
    return '$houseNumber, $street, $area, $pincode, $city, $state, $country , Mobile Number :- $mobileNumber';
  }

  void clearAddress() {}
}
