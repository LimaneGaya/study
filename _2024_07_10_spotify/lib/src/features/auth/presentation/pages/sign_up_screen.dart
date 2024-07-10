import 'package:flutter/material.dart';

import '../widgets/auth_gradient_button.dart';
import '../widgets/custom_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

const titleStyle = TextStyle(fontSize: 35, fontWeight: FontWeight.bold);

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCont = TextEditingController();
  final _passwordCont = TextEditingController();
  final _passwordConfirmCont = TextEditingController();
  @override
  void dispose() {
    _emailCont.dispose();
    _passwordCont.dispose();
    _passwordConfirmCont.dispose();
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
              CustomField('Email', controller: _emailCont),
              const SizedBox(height: 10),
              CustomField('Password', controller: _passwordCont),
              const SizedBox(height: 10),
              CustomField('Confirm Password', controller: _passwordConfirmCont),
              const SizedBox(height: 10),
              AuthGradientButton(onPressed: () {}, text: 'Sign Up'),
            ],
          ),
        ),
      ),
    );
  }
}
