import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medimate/src/pesentation/homepage.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSigningIn = false;

  Future<void> signInWithGoogle() async {
    if (_isSigningIn) return;
    setState(() => _isSigningIn = true);

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() => _isSigningIn = false);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Google Sign-In Failed: $e")));
    } finally {
      setState(() => _isSigningIn = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title text
            const Text.rich(
              TextSpan(
                text: 'Welcome to the ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Medimate',
                    style: TextStyle(color: Color.fromARGB(255, 229, 139, 253), fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' reminder app'),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // App Image
            Image.asset('assets/images/medico_clock.png', width: 200),

            const SizedBox(height: 30),

            // Get Started Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSigningIn ? null : signInWithGoogle,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 229, 139, 253),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isSigningIn
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Get started',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
              ),
            ),

            const SizedBox(height: 15),

            // Sign In text link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account? ',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                GestureDetector(
                  onTap: signInWithGoogle,
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 229, 139, 253)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
