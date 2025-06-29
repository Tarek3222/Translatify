import 'package:flutter/material.dart';
import 'package:translator/features/sign_up/ui/widgets/sign_up_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SignUpBody(),
      ),
    );
  }
}
