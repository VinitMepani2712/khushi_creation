import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ProfileProvider with ChangeNotifier {
  User? user;
  String? userId;
  File? image;
  String? name;
  String? email;
  String? phoneNumber;
  String? gender;
  String? dateOfBirth;
  final picker = ImagePicker();
  final auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  final firestore = FirebaseFirestore.instance;

  String get photoURL => user?.photoURL ?? 'assets/images/profile/upload.jpg';

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> uploadImage() async {
    if (image == null || userId == null) return;
    try {
      final ref = storage.ref().child('user_images').child(userId! + '.jpg');
      await ref.putFile(image!);
      final url = await ref.getDownloadURL();
      await user!.updatePhotoURL(url);
      await firestore.collection('users').doc(userId).update({'photoURL': url});
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateEmail(String email) async {
    try {
      await user!.verifyBeforeUpdateEmail(email);
      await user!.sendEmailVerification();
      await firestore.collection('users').doc(userId).update({'email': email});
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updatePhoneNumber(String email) async {
    try {
      await user!.verifyBeforeUpdateEmail(email);
      await user!.sendEmailVerification();
      await firestore
          .collection('users')
          .doc(userId)
          .update({'phoneNumber': phoneNumber});
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updatePassword(
      String currentPassword, String newPassword) async {
    user = auth.currentUser;
    if (user == null) return;

    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: currentPassword,
      );
      await user!.reauthenticateWithCredential(credential);
      await user!.updatePassword(newPassword);
      notifyListeners();
    } catch (e) {
      throw Exception('Current password is incorrect');
    }
  }

  Future<void> updateProfile({String? email, String? password}) async {
    try {
      if (image != null) await uploadImage();
      if (email != null && email != user!.email) await updateEmail(email);
      if (password != null && password.isNotEmpty)
        await updatePassword(email!, password);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteAccount(String password) async {
    user = auth.currentUser;
    if (user == null) return;

    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: password,
      );
      await user!.reauthenticateWithCredential(credential);
      await firestore.collection('users').doc(userId).delete();
      await user!.delete();
      notifyListeners();
    } catch (e) {
      print(e);
      throw Exception('Error deleting account: ${e.toString()}');
    }
  }

  Future<void> fetchUserProfile() async {
    user = auth.currentUser;
    if (user != null) {
      userId = user!.uid;
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await firestore.collection('users').doc(userId).get();
      Map<String, dynamic>? data = userDoc.data();
      if (data != null) {
        name = data['name'];
        email = data['email'];
        phoneNumber = data['phoneNumber'];
        gender = data['gender'];
        dateOfBirth = data['dateOfBirth'];
        if (data.containsKey('photoURL')) {
          await user!.updatePhotoURL(data['photoURL']);
        }
      }
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await fetchUserProfile();
    } catch (e) {
      print(e);
      throw Exception('Error logging in: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
    user = null;
    userId = null;
    name = null;
    email = null;
    phoneNumber = null;
    gender = null;
    dateOfBirth = null;
    notifyListeners();
  }

  void getUserName() async {
    User? user = auth.currentUser;
    if (user != null) {
      email = user.email;
      userId = user.uid;
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await firestore.collection('users').doc(userId).get();
      Map<String, dynamic>? data = userDoc.data();
      name = data?['name'];
    }
  }

  void getUserEmail() async {
    User? user = auth.currentUser;
    if (user != null) {
      email = user.email;
      userId = user.uid;
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await firestore.collection('users').doc(userId).get();
      Map<String, dynamic>? data = userDoc.data();
      email = data?['email'];
    }
  }

  void getUserMobileNumber() async {
    User? user = auth.currentUser;
    if (user != null) {
      email = user.email;
      userId = user.uid;
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await firestore.collection('users').doc(userId).get();
      Map<String, dynamic>? data = userDoc.data();
      phoneNumber = data?['phoneNumber'];
    }
  }

  void getUserGender() async {
    User? user = auth.currentUser;
    if (user != null) {
      email = user.email;
      userId = user.uid;
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await firestore.collection('users').doc(userId).get();
      Map<String, dynamic>? data = userDoc.data();
      gender = data?['gender'];
    }
  }

  Future<String> uploadProfileImage(File imageFile) async {
    try {
      String fileName = path.basename(imageFile.path);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('profile_images/$fileName');

      UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;

      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      throw e;
    }
  }
}
