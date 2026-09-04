import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/failures/auth_failure.dart';
import '../../../../generated/l10n.dart';
import '../../../../main.dart';
import '../../states/auth_state.dart';
import 'auth_failure_message.dart';

/// Login screen shown when there is no authenticated user.
///
/// Authentication logic lives entirely in [AuthProvider]; this screen only
/// collects input, reflects state, and renders localized, theme-aware UI.
class LoginScreen extends StatelessWidget {
  /// Default constructor.
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: const _LoginBodyWidget(),
        ),
      ),
    );
  }
}

class _LoginBodyWidget extends StatelessWidget {
  const _LoginBodyWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 32,
            children: [
              _LoginHeaderWidget(),
              _LoginFormWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginHeaderWidget extends StatelessWidget {
  const _LoginHeaderWidget();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final brand = colorDefault.mainColor;
    final bodyColor = theme.textTheme.bodyMedium?.color;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(
            height: 72,
            width: 72,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: brand.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.lock_outline_rounded,
              size: 34,
              color: brand,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          s.loginTitle,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          s.loginSubtitle,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: bodyColor?.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}

class _LoginFormWidget extends StatefulWidget {
  const _LoginFormWidget();

  @override
  State<_LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<_LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _toggleObscure() {
    setState(() => _obscurePassword = !_obscurePassword);
  }

  void _submit() {
    FocusManager.instance.primaryFocus?.unfocus();
    final auth = context.read<AuthProvider>();
    if (auth.loading) {
      return;
    }
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    auth.login(auth.emailController.text, auth.passwordController.text);
  }

  String? _validateEmail(String? value) {
    final s = S.of(context);
    final text = (value ?? '').trim();
    if (text.isEmpty) {
      return s.validationEmailRequired;
    }
    final emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailPattern.hasMatch(text)) {
      return s.validationEmailInvalid;
    }
    return null;
  }

  String? _validatePassword(String? value) {
    final s = S.of(context);
    if ((value ?? '').isEmpty) {
      return s.validationPasswordRequired;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final s = S.of(context);

    return AutofillGroup(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo de email usando o widget padronizado.
            _AuthTextField(
              controller: auth.emailController,
              focusNode: _emailFocus,
              label: s.emailLabel,
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [
                AutofillHints.username,
                AutofillHints.email,
              ],
              validator: _validateEmail,
              onChanged: auth.clearFailure,
              onSubmitted: _passwordFocus.requestFocus,
            ),
            const SizedBox(height: 16),
            // Campo de senha usando o mesmo widget padronizado.
            _AuthTextField(
              controller: auth.passwordController,
              focusNode: _passwordFocus,
              label: s.passwordLabel,
              icon: Icons.lock_outline_rounded,
              obscureText: _obscurePassword,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
              validator: _validatePassword,
              onChanged: auth.clearFailure,
              onSubmitted: _submit,
              suffixIcon: IconButton(
                onPressed: _toggleObscure,
                tooltip: _obscurePassword ? s.showPassword : s.hidePassword,
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              ),
            ),
            const SizedBox(height: 4),
            _LoginErrorWidget(failure: auth.failure),
            const SizedBox(height: 12),
            _LoginButtonWidget(loading: auth.loading, onPressed: _submit),
          ],
        ),
      ),
    );
  }
}

/// Campo de texto padrão usado pelo fluxo de autenticação (email e senha).
///
/// Centraliza estilo, borda e comportamento comuns em um único lugar, para
/// que qualquer novo campo de auth (ex.: confirmação de senha, cadastro)
/// reutilize exatamente a mesma aparência.
class _AuthTextField extends StatelessWidget {
  const _AuthTextField({
    required this.controller,
    required this.focusNode,
    required this.label,
    required this.icon,
    required this.validator,
    required this.onChanged,
    required this.onSubmitted,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.autofillHints,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final IconData icon;
  final FormFieldValidator<String> validator;
  final VoidCallback onChanged;
  final VoidCallback onSubmitted;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final Iterable<String>? autofillHints;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final brand = colorDefault.mainColor;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(
        color: colorDefault.offColor.withValues(alpha: 0.3),
      ),
    );

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autocorrect: false,
      enableSuggestions: false,
      autofillHints: autofillHints,
      validator: validator,
      onChanged: (_) => onChanged(),
      onFieldSubmitted: (_) => onSubmitted(),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: colorDefault.backGroundColor,
        border: border,
        enabledBorder: border,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: brand, width: 2),
        ),
      ),
    );
  }
}

class _LoginErrorWidget extends StatelessWidget {
  const _LoginErrorWidget({required this.failure});

  final AuthFailure? failure;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final errorColor = theme.colorScheme.error;
    final currentFailure = failure;

    // AnimatedSize keeps the layout from jumping abruptly when the error
    // appears or disappears.
    return AnimatedSize(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      alignment: Alignment.topCenter,
      child: currentFailure == null
          ? const SizedBox(width: double.infinity)
          : Semantics(
        liveRegion: true,
        container: true,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: errorColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: errorColor.withValues(alpha: 0.4)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.error_outline_rounded,
                color: errorColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  currentFailure.localized(S.of(context)),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: errorColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginButtonWidget extends StatelessWidget {
  const _LoginButtonWidget({required this.loading, required this.onPressed});

  final bool loading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final brand = colorDefault.mainColor;
    final onBrand = colorDefault.offColor;

    return SizedBox(
      height: 52,
      child: FilledButton(
        onPressed: loading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: brand,
          foregroundColor: onBrand,
          disabledBackgroundColor: brand.withValues(alpha: 0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: loading
            ? SizedBox(
          height: 22,
          width: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(onBrand),
          ),
        )
            : Text(
          S.of(context).loginButton,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}