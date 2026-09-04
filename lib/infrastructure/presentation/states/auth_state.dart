import 'package:flutter/material.dart';

import '../../../domain/failures/auth_failure.dart';
import 'login_state.dart';

/// Provider responsável por todo o estado e a lógica de autenticação.
///
/// A [LoginScreen] apenas observa este provider: coleta input do usuário e
/// reflete o estado exposto aqui (`loading`, `failure`). Toda a lógica de
/// autenticação (chamada ao repositório, tratamento de erro) vive nesta
/// classe, mantendo a tela "burra" (apenas UI).
class AuthProvider extends ChangeNotifier {
  AuthProvider({required FirebaseAuthRepository authRepository})
    : _authRepository = authRepository;

  final FirebaseAuthRepository _authRepository;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _loading = false;

  bool get loading => _loading;

  AuthFailure? _failure;

  AuthFailure? get failure => _failure;

  /// Limpa a mensagem de erro exibida. Chamado, por exemplo, quando o
  /// usuário volta a digitar em algum dos campos após um erro de login.
  void clearFailure() {
    if (_failure == null) return;
    _failure = null;
    notifyListeners();
  }

  /// Executa o login com email e senha.
  ///
  /// Assume que [UserRepository.signInWithEmailAndPassword] retorna um
  /// `Either<AuthFailure, Unit>` (padrão dartz). Ajuste o `fold` abaixo caso
  /// seu repositório use outra assinatura (ex.: try/catch com exceptions).
  Future<void> login(String email, String password) async {
    if (_loading) return;

    _loading = true;
    _failure = null;
    notifyListeners();

    try {
      await _authRepository.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      passwordController.clear();
      _loading = false;
      notifyListeners();
    } on Exception {
      _failure = failure;
      _loading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
