
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/failures/auth_failure.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _mapException(e);
    } catch (_) {
      throw AuthFailure.configurationError;
    }
  }

  AuthFailure _mapException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return AuthFailure.invalidCredentials;
      case 'user-disabled':
      case 'too-many-requests':
      case 'network-request-failed':
      default:
        return AuthFailure.configurationError;
    }
  }
}


/// [FirebaseAuthRepository].
abstract class AuthRepository {
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}