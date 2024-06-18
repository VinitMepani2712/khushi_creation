import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khushi_creation/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:khushi_creation/screens/location/location_screen.dart';
import 'package:khushi_creation/widget/widget_support.dart';

class AuthenticationProvider extends ChangeNotifier {
  String _name = "";
  String _email = "";
  String _password = "";
  bool _isPasswordVisible = false;
  bool _isLoggingIn = false;
  bool _isSignIn = false;
  bool isChecked = false;

  String get name => _name;
  String get email => _email;
  String get password => _password;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isLoggingIn => _isLoggingIn;
  bool get isSignIn => _isSignIn;
  bool showCheckboxError = false;

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setChecked(bool value) {
    isChecked = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  Future<void> updateUserProfile(
      String name, String phoneNumber, String gender, String imageUrl) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      final CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      await users.doc(userId).update({
        'name': name,
        'phoneNumber': phoneNumber,
        'gender': gender,
      });
    } catch (e) {
      throw e;
    }
  }

  Future<void> userSignIn(BuildContext context) async {
    _isLoggingIn = true;
    notifyListeners();

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': _email,
        'name': _name,
      }, SetOptions(merge: true));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavBar(),
        ),
      );
    } on FirebaseAuthException catch (e) {

      if (e.code == 'user-not-found') {
        SnackBar(
          backgroundColor: Colors.brown,
          content: Text(
            "User id is not registered",
            style: AppWidget.snackbarTextStyle(),
          ),
        );
      } else if (e.code == 'wrong-password') {
        SnackBar(
          backgroundColor: Colors.brown,
          content: Text(
            "Your password is wrong! Please try again",
            style: AppWidget.snackbarTextStyle(),
          ),
        );
      }
    } finally {
      _isLoggingIn = false;
      notifyListeners();
    }
  }

  Future<void> registration(BuildContext context, bool isChecked) async {
    if (!isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.brown,
          content: Text(
            "You must agree to the Terms & Conditions",
            style: AppWidget.snackbarTextStyle(),
          ),
        ),
      );
      return;
    }

    if (_email.isEmpty || _password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.brown,
          content: Text(
            "Email and Password cannot be empty",
            style: AppWidget.snackbarTextStyle(),
          ),
        ),
      );
      return;
    }

    _isSignIn = true;
    notifyListeners();

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.brown,
          content: Text(
            "Registered Successfully",
            style: AppWidget.snackbarTextStyle(),
          ),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LocationScreen(),
        ),
      );

      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': _email,
        'name': _name,
      }, SetOptions(merge: true));
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      if (e.code == "weak-password") {
        errorMessage = "Provided password is not greater than 8 characters";
      } else if (e.code == "email-already-in-use") {
        errorMessage = "Account is already in use, Please log in";
      } else {
        errorMessage = "An error occurred: ${e.message}";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.brown,
          content: Text(
            errorMessage,
            style: AppWidget.snackbarTextStyle(),
          ),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.brown,
          content: Text(
            error.toString(),
            style: AppWidget.snackbarTextStyle(),
          ),
        ),
      );
    } finally {
      _isSignIn = false;
      notifyListeners();
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        print('User cancelled Google sign-in');
        return;
      }
      _firestore
          .collection('users')
          .doc(googleSignInAccount.serverAuthCode)
          .set(
        {
          'uid': googleSignInAccount.id,
          'email': googleSignInAccount.email,
          'name': googleSignInAccount.displayName,
        },
        SetOptions(merge: true),
      );

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LocationScreen(),
          ),
        );
      } else {
        print('User is null after sign-in');
      }
    } catch (e, stackTrace) {
      print('Error signing in with Google: $e');
      print(stackTrace);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Failed to sign in with Google. Please try again later.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }
}
