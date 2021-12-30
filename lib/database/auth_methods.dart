import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../functions/time_date_function.dart';
import '../models/app_user.dart';
import '../widgets/custom_widgets/custom_toast.dart';
import 'user_api.dart';

class AuthMethods {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static User? get getCurrentUser => _auth.currentUser;

  static String get uid => _auth.currentUser?.uid ?? '';

  static String get uniqueID => '$uid-post-${TimeDateFunctions.timestamp}';

  Future<User?>? signupWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential result = await _auth
          .createUserWithEmailAndPassword(
        email: email.toLowerCase().trim(),
        password: password.trim(),
      )
          .catchError((Object obj) {
        CustomToast.errorToast(message: obj.toString());
      });
      final User? user = result.user;
      assert(user != null);
      return user;
    } catch (signUpError) {
      CustomToast.errorToast(message: signUpError.toString());
      return null;
    }
  }

  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential result = await _auth
          .signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      )
          .catchError((Object obj) {
        CustomToast.errorToast(message: obj.toString());
      });
      final User? user = result.user;
      final AppUser? appUser = await UserAPI().user(uid: user!.uid);
      return user;
    } catch (signUpError) {
      CustomToast.errorToast(message: signUpError.toString());
      return null;
    }
  }
  Future<User?> emailExist({required String email, required String password,}) async {
    try {
      final UserCredential result = await _auth
          .createUserWithEmailAndPassword(
        email: email.toLowerCase().trim(),
        password: password.trim(),
      )
          .catchError((Object obj) {
        CustomToast.errorToast(message: obj.toString());
      });
      final User? user = result.user;
      assert(user != null);

      // Check if user with same email already exists
      final QuerySnapshot<Map<String, dynamic>> existingUser = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (existingUser.docs.isNotEmpty) {
        throw Exception('A user with this email already exists.');
      }

      return user;
    } catch (signUpError) {
      CustomToast.errorToast(message: signUpError.toString());
      return null;

    }
  }
  final CollectionReference _userCollection = FirebaseFirestore.instance.collection('users');
  Future<User?> loginWithEmailAndPasswords(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      DocumentSnapshot userDoc =
      await _userCollection.doc(user!.uid).get();
      bool isBlocked = userDoc.get('isBlock') ?? false;
      if (isBlocked) {
        await _auth.signOut();
        return null;
      }
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }


  Future<bool> forgetPassword(String email) async {
    try {
      _auth.sendPasswordResetEmail(email: email.trim());
      return true;
    } catch (error) {
      CustomToast.errorToast(message: error.toString());
    }
    return false;
  }
   Future<void> signOut() async {
    await _auth.signOut();
  }




}
