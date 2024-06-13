import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileProvider with ChangeNotifier {
  User? user;
  File? _image;
  String? _name;
  String? _mobileNumber;
  String? _gender;
  String? _dateOfBirth;
  final picker = ImagePicker();
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;

  ProfileProvider() {
    user = _auth.currentUser;
    // name = user?.displayName;
  }

  String get name => user?.displayName ?? '';
  File? get image => _image;
  String get email => user?.email ?? '';
  String get photoURL => user?.photoURL ?? '';
  String get userId => user?.uid ?? '';
  String get phoneNumber => user?.phoneNumber ?? '';
  // String get gender =>  user?.;
  String? get dateOfBirth => _dateOfBirth;

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();
    }
  }

  // void updateName(String name) {
  //   _name = name;
  //   notifyListeners();
  // }

  // void updatePhoneNumber(String phoneNumber) {
  //   _mobileNumber = phoneNumber;
  //   notifyListeners();
  // }

  // void updateGender(String gender) {
  //   _gender = gender;
  //   notifyListeners();
  // }

  // void updateDateOfBirth(String dateOfBirth) {
  //   _dateOfBirth = dateOfBirth;
  //   notifyListeners();
  // }

  Future<void> uploadImage() async {
    if (_image == null) return;
    try {
      final ref = _storage.ref().child('user_images').child(user!.uid + '.jpg');
      await ref.putFile(_image!);
      final url = await ref.getDownloadURL();
      await user!.updatePhotoURL(url);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateEmail(String email) async {
    try {
      await user!.verifyBeforeUpdateEmail(email);
      await user!.sendEmailVerification();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updatePassword(String password) async {
    try {
      await user!.updatePassword(password);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateProfile({String? email, String? password}) async {
    try {
      if (_image != null) await uploadImage();
      if (email != null && email != user!.email) await updateEmail(email);
      if (password != null && password.isNotEmpty)
        await updatePassword(password);
    } catch (e) {
      print(e);
    }
  }

  void updateMobileNumber(String mobileNumber) {
    // Update the mobile number here
  }

  Future<void> deleteAccount() async {
    try {
      await user!.delete();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
