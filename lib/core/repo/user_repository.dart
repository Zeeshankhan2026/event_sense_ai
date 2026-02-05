import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_sense_ai/core/models/jobs_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/users_model.dart';

class UserRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn.instance;


////================create user with emaiil =================
  Future<void> createUserWithEmail(UserModel userModel) async {
    try {
      UserCredential userCredential =
      await auth.createUserWithEmailAndPassword(
        email: userModel.email!.trim(),
        password: userModel.password!.trim(),
      );

      final uid = userCredential.user!.uid;

      await firestore.collection("users").doc(uid).set({
        "name": userModel.name,
        "email": userModel.email,
        "profile_image": userModel.profileImage,
        "user_id": uid,
        "role" : "planner",
      });
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

////================Login user user with emaiil =================

  Future loginUserWithEmail(String email, String password) async {
    try {

      await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    }
    catch (e) {
      rethrow ;
    }
  }


  ////================create user with google =================
  Future<void> createUserGoogle() async {
    try {
      await googleSignIn.initialize(
        serverClientId:
        "121087080478-jbs0ojst9fu32j8ct84ipjr9opf1u8o3.apps.googleusercontent.com",
      );

      final GoogleSignInAccount? googleUser = await googleSignIn.authenticate();

      // USER CANCELLED — NOT AN ERROR
      if (googleUser == null) {
        return; // just exit silently
      }

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await auth.signInWithCredential(
        credential,
      );
      if (userCredential.user != null) {
        await firestore.collection("users").doc(auth.currentUser!.uid).set({
          "name": userCredential.user!.displayName,
          "email": userCredential.user!.email,
          "password": "",
          "confirmPassword": "",
          "role" : "planner",
          "profile_image": userCredential.user!.photoURL,
          "user_id": userCredential.user!.uid,
        }, SetOptions(merge: true));
      }
    }
    on FirebaseAuthException catch (e) {
      if(e.code == "network-request-failed") {
        throw "No internet connection.";
      }
      throw e.message ?? "Google sign-in failed";
    } catch (e) {
      throw e.toString();
    }
  }


  ///////////////get user profile =========================
  Future<UserModel> getUserProfile(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();

    if (!doc.exists) {
      throw "User not found";
    }

    return UserModel.fromJson(doc.data()!);
  }



  ///Logout User ====================================
  Future<void> logOutUser() async {
    await googleSignIn.signOut();
    await auth.signOut();
  }

}
