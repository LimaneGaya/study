import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:spotmusic/src/features/auth/data/repositories/auth_repository.dart';

import '../../../../core/theme/app_pallete.dart';
import '../widgets/auth_gradient_button.dart';
import '../widgets/custom_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

const titleStyle = TextStyle(fontSize: 35, fontWeight: FontWeight.bold);
// TODO: Make it like Register Screen
class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCont = TextEditingController();
  final _passwordCont = TextEditingController();
  @override
  void dispose() {
    _emailCont.dispose();
    _passwordCont.dispose();
    super.dispose();
  }

  Widget shell(Widget child) {
    return Center(
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: child)));
  }

  String? vEmail(String? v) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    v = v?.trim();
    if (v == null || v.isEmpty) return 'Email can\'t be empty';
    if (!emailRegex.hasMatch(v)) return 'Invalid email';
    return null;
  }

  String? vPassword(String? v) {
    v = v?.trim();
    if (v == null || v.isEmpty) return 'Password can\'t be empty';
    if (v.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell(
        Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Sign Up', style: titleStyle),
              const SizedBox(height: 35),
              CustomField('Email', cont: _emailCont, validator: vEmail),
              const SizedBox(height: 10),
              CustomField('Password',
                  cont: _passwordCont, isObscured: true, validator: vPassword),
              const SizedBox(height: 10),
              AuthGradientButton(
                  onPressed: () async {
                    //TODO: Implement real Clean Architecture with SOLID principles
                    if (_formKey.currentState!.validate()) {
                      final data = await AuthRepository().login(
                        _emailCont.text,
                        _passwordCont.text,
                      );

                      showBottomSheet(
                          context: context,
                          builder: (context) {
                            if (data != null) {
                              return Text(data.toJson().toString());
                            } else {
                              return const Text('Login failed');
                            }
                          });
                    }
                  },
                  text: 'Log In'),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: 'Don\'t have an account? ',
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: 'Sign Un',
                      style: const TextStyle(
                        color: Pallete.gradient2,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          throw UnimplementedError('move to Sign In page');
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
