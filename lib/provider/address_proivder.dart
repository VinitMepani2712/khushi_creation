import 'package:flutter/material.dart';

class AddressProvider with ChangeNotifier {
  String? houseNumber = '';
  String? street = '';
  String? area = '';
  String? pincode = '';
  String? city = '';
  String? state = '';
  String? country = '';
  String addressType = 'Home';
  String? customAddressType = '';

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

  void setCustomAddressType(String value) {
    customAddressType = value;
    notifyListeners();
  }

  String get fullAddress {
    return '$houseNumber, $street, $area, $pincode, $city, $state, $country';
  }
}
