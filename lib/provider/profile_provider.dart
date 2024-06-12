import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileProvider with ChangeNotifier {
  User? user;
  File? _image;
  final picker = ImagePicker();
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;

  ProfileProvider() {
    user = _auth.currentUser;
  }

  File? get image => _image;
  String get email => user?.email ?? '';
  String get photoURL => user?.photoURL ?? 'https://via.placeholder.com/150';

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();
    }
  }

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
      await user!.updateEmail(email);
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

  Future<void> saveChanges(String email, String password) async {
    if (_image != null) await uploadImage();
    if (email != user!.email) await updateEmail(email);
    if (password.isNotEmpty) await updatePassword(password);
  }
}
