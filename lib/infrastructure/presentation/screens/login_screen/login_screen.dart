import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../states/login_state.dart';

/// Login screen if no has access
class LoginScreen extends StatelessWidget {
  /// Default constructor
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: state.emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: state.passwordController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              if (state.loading) const CircularProgressIndicator(),
              if (!state.loading)
                ElevatedButton(
                  onPressed: () {
                    state.login(
                      state.emailController.text,
                      state.passwordController.text,
                    );
                  },
                  child: const Text('Login'),
                ),
              if (state.errorMessage != null)
                Text(
                  state.errorMessage!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
