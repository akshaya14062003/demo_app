import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final FirebaseAuth _auth =
      FirebaseAuth.instance;

  static final GoogleSignIn _googleSignIn =
      GoogleSignIn.instance;

  // Google Sign-In initialization
  static Future<void>? _googleInitialization;

  static Future<void> initializeGoogleSignIn() {
    return _googleInitialization ??=
        _googleSignIn.initialize(
          serverClientId:
          '246266495731-rdm7kd347bfirduckrggchv62hv7dcg4.apps.googleusercontent.com',
        );
  }



  static Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(
        e.message ?? 'Registration failed',
      );
    }
  }



  static Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(
        e.message ?? 'Login failed',
      );
    }
  }



  static Future<UserCredential> loginWithGoogle() async {
    try {
      // Initialize Google Sign-In
      await initializeGoogleSignIn();

      // Open Google account selection
      final GoogleSignInAccount googleUser =
      await _googleSignIn.authenticate();

      // Get Google authentication
      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      // Create Firebase credential
      final AuthCredential credential =
      GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Login to Firebase
      return await _auth.signInWithCredential(
        credential,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(
        e.message ?? 'Google login failed',
      );
    } catch (e) {
      throw Exception(
        'Google login failed: $e',
      );
    }
  }



  static Future<void> forgotPassword({
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email.trim(),
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(
        e.message ?? 'Unable to send reset email',
      );
    }
  }

  static Future<void> logout() async {
    await _auth.signOut();
  }



  static User? get currentUser {
    return _auth.currentUser;
  }

  static bool get isLoggedIn {
    return _auth.currentUser != null;
  }
}