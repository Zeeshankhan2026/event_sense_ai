import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_sense_ai/core/models/vendor_model.dart';
import 'package:event_sense_ai/core/widgets/snackbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class VendorRepository {

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;




  Future<void> createVendor(VendorModel vendorModel) async {

  try{
    UserCredential userCredential =  await auth.createUserWithEmailAndPassword(
        email: vendorModel.email!.trim() ,
        password: vendorModel.password!.trim());
    if(userCredential.user != null){
      await firestore.collection("users").doc(userCredential.user!.uid).set({
        "companyName": vendorModel.companyName,
        "serviceCategory" : vendorModel.serviceCategory,
        "location" : vendorModel.location,
        "email" : vendorModel.email,
        "password" : vendorModel.password,
        "phone" : vendorModel.phone,
        "profileImage" : vendorModel.profileImage,
        "vendor_uid" : userCredential.user!.uid,
        "role" : "vendor",
      });
    }
  }
  catch (e){
    rethrow;
  }
  }


  Future<void> createVendorGoogle () async {
    try{

      await googleSignIn.initialize(
          serverClientId: "121087080478-jbs0ojst9fu32j8ct84ipjr9opf1u8o3.apps.googleusercontent.com");
      GoogleSignInAccount googleSignInAccount = await   googleSignIn.authenticate();
      GoogleSignInAuthentication  googleAuth =  googleSignInAccount.authentication;

      final  credential  =   GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

   UserCredential userCredential =    await  auth.signInWithCredential(credential);
   if(userCredential.user != null){
     await FirebaseFirestore.instance.collection("users").doc(userCredential.user!.uid).set(
         {
           "companyName" : userCredential.user!.displayName,
           "email" : userCredential.user!.email,
           "profileImage" : userCredential.user!.photoURL,
           "serviceCategory" : "",
           "phone" : "",
           "location" : "",
           "vendor_uid" : userCredential.user!.uid,
           "role" : "vendor"
         }, SetOptions(merge: true));
   }
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        throw 'This email is already registered with a different sign-in method';
      }
      rethrow;
    }
    catch (e){
      throw("error occurred" , e.toString());
    }
  }



  Future<VendorModel> getVendorProfile(String uid) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    try{
      final doc =  await _firestore.collection('users').doc(uid).get();

      if (!doc.exists) {
        throw Exception('User not found');
      }

      return VendorModel.FromJson(doc.data()!);
    }
    catch (e) {
      throw "something wrong\n${e.toString()}";
    }
  }


  Future<void> updateVendor({
    required String name,
    required String category,
    required String location,
    required String phone ,
    required String userId}) async {
    try{

      await FirebaseFirestore.instance.collection("users").doc(userId).update({
        "companyName" : name,
        "serviceCategory" : category,
        "location" : location,
        "phone" : phone,
      });
    }catch (e){
      throw ("error" , e.toString());
    }

  }


  Future<void> LoginVendorWithEmail(String email, String password) async {

    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);

    }
    on FirebaseAuthException catch (e) {
      rethrow;
    }

    catch (e){
     rethrow;
    }
  }

  Future<void> VendorLogout() async {
    try{
      await auth.signOut();
    }
    on FirebaseAuthException catch (e) {
      throw e.message ?? "Login failed";
    }

    catch (e){
      throw("something went wrong error" , e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> vendorStream() {
    return FirebaseFirestore.instance
        .collection("users")
        .where("role", isEqualTo: "vendor")
        .snapshots();
  }
}