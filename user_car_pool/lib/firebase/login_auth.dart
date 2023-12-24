import 'package:firebase_auth/firebase_auth.dart';



Future<Map<String, dynamic>> loginAuthenticator (String email, String password) async {

  Map<String, dynamic> results = {
    'PassExceptionFired': false,
    'EmailExceptionFired': false,
    'ExceptionFired': false
  };
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: "user_$email",
      password: password
    );
  } on FirebaseAuthException catch (e) {
    print(e.code);
    if (e.code == 'user-not-found') {
      results['PassExceptionFired'] = true;

      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      results['PassExceptionFired'] = true;

      print('Wrong password provided for that user.');
    }
    else {
      results['ExceptionFired'] = true;
      print(e);
    }
  }
  return results;
}