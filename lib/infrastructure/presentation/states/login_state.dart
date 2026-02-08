import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Provides authentication state and logic for the application.
///
/// Manages user authentication status, login, and logout operations
/// using Firebase Authentication. It notifies listeners when the auth
/// state changes.
class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Initializes the provider and listens for authentication state changes.
  AuthProvider() {
    _auth.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  User? _user;

  bool _loading = false;

  String? _errorMessage;

  /// Controller of email getter
  TextEditingController get emailController => _emailController;

  /// Controller of password getter
  TextEditingController get passwordController => _passwordController;

  /// The currently signed-in user, or `null` if no user is signed in.
  User? get user => _user;

  /// A flag to indicate if an authentication operation is in progress.
  bool get loading => _loading;

  /// An error message resulting from a failed authentication attempt.
  String? get errorMessage => _errorMessage;

  /// Attempts to sign in a user with the given [email] and [password].
  Future<void> login(String email, String password) async {
    _loading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// Signs out the current user.
  Future<void> logout() async {
    await _auth.signOut();
  }
}
