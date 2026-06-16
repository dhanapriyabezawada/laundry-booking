import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class LoginScreen extends StatelessWidget {
    Future<UserCredential?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn().signIn();

    if (googleUser == null) {
      return null;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(
      credential,
    );
  } catch (e) {
    print("Google Sign-In Error: $e");
    return null;
  }
}
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
 body: Center(
  child: ElevatedButton(
    onPressed: () async {
      final userCredential = await signInWithGoogle();
    

 if (userCredential != null) {

  //await FirebaseFirestore.instance
    //  .collection('users')
      //.doc(userCredential.user!.uid)
      //.set({
    //'name': userCredential.user!.displayName,
    //'email': userCredential.user!.email,
   // 'createdAt': FieldValue.serverTimestamp(),
 // });

 if (userCredential != null) {

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        "Login Successful",
      ),
    ),
  );

  Navigator.pushReplacementNamed(
  context,
  '/dashboard',
);
}

  Navigator.pushReplacementNamed(
    context,
    '/home',
  );
}
    },
    child: const Text("Continue with Google"),
  ),
),
    );
  }
}