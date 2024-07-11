import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:spotmusic/service_locator.dart';
import 'package:spotmusic/src/features/auth/data/repositories/auth_repository.dart';

import '../../../../core/theme/app_pallete.dart';
import '../widgets/auth_gradient_button.dart';
import '../widgets/custom_field.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Main(),
          ),
        ),
      ),
    );
  }
}

const titleStyle = TextStyle(fontSize: 35, fontWeight: FontWeight.bold);

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  final _formKey = GlobalKey<FormState>();
  final _nameCont = TextEditingController();
  final _emailCont = TextEditingController();
  final _passwordCont = TextEditingController();
  @override
  void dispose() {
    _nameCont.dispose();
    _emailCont.dispose();
    _passwordCont.dispose();
    super.dispose();
  }

  String? vName(String? v) {
    v = v?.trim();
    if (v == null || v.isEmpty) return 'Name can\'t be empty';
    if (v.length < 3) return 'Name must be at least 3 characters';
    return null;
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
    print(getit<PocketBase>().authStore.isValid.toString());
    print(getit<PocketBase>().authStore.token.toString());
    print(getit<PocketBase>().authStore.model.toString());
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Sign Up', style: titleStyle),
          const SizedBox(height: 35),
          CustomField('Name', cont: _nameCont, validator: vName),
          const SizedBox(height: 10),
          CustomField('Email', cont: _emailCont, validator: vEmail),
          const SizedBox(height: 10),
          CustomField('Password',
              cont: _passwordCont, isObscured: true, validator: vPassword),
          const SizedBox(height: 10),
          AuthGradientButton(
              onPressed: () async {
                //TODO: Implement real Clean Architecture with SOLID principles

                if (!_formKey.currentState!.validate()) return;
                final data = await AuthRepository().signup(
                  _nameCont.text,
                  _emailCont.text,
                  _passwordCont.text,
                );
                showBottomSheet(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: data != null
                            ? Text(data.toJson().toString())
                            : const Text('Sign Up Failed'),
                      );
                    });
              },
              text: 'Sign Up'),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              text: 'Already have an account? ',
              style: Theme.of(context).textTheme.titleMedium,
              children: [
                TextSpan(
                  text: 'Log In',
                  style: const TextStyle(
                    color: Pallete.gradient2,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      throw UnimplementedError('move to Log In page');
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
