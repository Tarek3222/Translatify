import 'package:flutter/material.dart';
import 'package:translator/features/settings/ui/widgets/change_password_body.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: ChangePasswordBody(),
      ),
    );
  }
}
