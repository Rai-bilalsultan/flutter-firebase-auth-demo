import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';
import 'login_form.dart';
import 'signup_form.dart';
import 'auth_constants.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AuthConstants.screenPadding),
            child: Column(
              children: [
                const _AuthHeader(),
                const SizedBox(height: AuthConstants.formSpacing),
                _AuthFormsContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthHeader extends StatelessWidget {
  const _AuthHeader();

  @override
  Widget build(BuildContext context) {
    final isLogin = context.select<AuthProvider, bool>((provider) => provider.isLogin);

    return Column(
      children: [
        // Removed FlutterLogo and just showing text
        Text(
          isLogin ? 'Login' : 'Sign Up',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 28, // Increased font size
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isLogin ? 'Welcome back to our app' : 'Create a new account',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class _AuthFormsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Consumer<AuthProvider>(
        key: ValueKey(context.watch<AuthProvider>().isLogin),
        builder: (context, provider, _) {
          return provider.isLogin ? const LoginForm() : const SignupForm();
        },
      ),
    );
  }
}