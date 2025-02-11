import 'package:flutter/material.dart';
import 'package:online_exam_app/Auth/Forget%20Password/View/EnterEmailForPasswordReset.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const routeName = '/ForgetPasswordScreen';
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EnterEmailForgetPassword();
  }
}
