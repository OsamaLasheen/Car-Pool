import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

Future<Map<String, dynamic>> signupAuthenticator(
    String emailAddress, String password, String firstName, String lastName, String phoneNumber) async {
  Map<String, dynamic> results = {
    'ExceptionFired': false,
    'PassExceptionFired': false,
    'EmailExceptionFired': false,
  };
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: "user_$emailAddress",
      password: password,
    );
    var firebaseDatabase = FirebaseDatabase.instanceFor(app: FirebaseDatabase.instance.app, 
      databaseURL: 'https://car-pool-8c38c-default-rtdb.europe-west1.firebasedatabase.app').ref();
    await firebaseDatabase.child('users/${credential.user?.uid}').set({
      'first name': firstName,
      'last name': lastName,
      'phone number': phoneNumber,
    });
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      results['PassExceptionFired'] = true;
      results['ExceptionFired'] = true;

      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      results['EmailExceptionFired'] = true;
      results['ExceptionFired'] = true;
      print('The account already exists for that email.');
    }
  } catch (e) {
    results['ExceptionFired'] = true;
    print(e);
  }
  return results;
}
