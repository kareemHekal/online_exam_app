// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:online_exam_app/Shared/Validator.dart';
import 'package:online_exam_app/Shared/custom_button.dart';
import 'package:online_exam_app/Shared/custom_password_text_field.dart';
import 'package:online_exam_app/Shared/custom_text_field.dart';
import 'package:online_exam_app/utils/config.dart';
import 'package:online_exam_app/utils/string_manager.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "/sign_up_screen";

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController firstNameController = TextEditingController();
  static TextEditingController lastNameController = TextEditingController();
  static TextEditingController phoneNumberController = TextEditingController();
  static TextEditingController userNameController = TextEditingController();
  static TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.signUp),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 24,
            children: [
              SizedBox(height: Config.screenHight! * 0.01),
              CustomTextField(
                  label: AppStrings.userName,
                  placeholder: AppStrings.enterUserName,
                  controller: userNameController,
                  validator: Validator.userName),
              Row(
                children: [
                  CustomTextField(
                    label: AppStrings.firstName,
                    placeholder: AppStrings.enterYourFirstName,
                    validator: Validator.firstName,
                    controller: firstNameController,
                  ),
                  CustomTextField(
                    label: AppStrings.lastName,
                    placeholder: AppStrings.enterYourLastName,
                    controller: lastNameController,
                    validator: Validator.lastName,
                  ),
                ],
              ),
              CustomTextField(
                label: AppStrings.email,
                placeholder: AppStrings.enterYourEmail,
                controller: emailController,
                validator: Validator.email,
              ),
              Row(
                children: [
                  CustomPasswordField(
                    label: AppStrings.password,
                    controller: passwordController,
                    validator: Validator.password,
                  ),
                  CustomPasswordField(
                    label: AppStrings.confirmPassword,
                    controller: confirmPasswordController,
                    validator: (value) => Validator.confirmPassword(
                        value, passwordController.text),
                  ),
                ],
              ),
              CustomTextField(
                label: AppStrings.phoneNumber,
                placeholder: AppStrings.enterYourPhoneNumber,
                controller: phoneNumberController,
                validator: Validator.phoneNumber,
              ),
              CustomButton(
                  onTap: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      log(AppStrings.signUpSuccessfully);
                    }
                  },
                  text: AppStrings.signUp),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.alreadyHaveAnAccount,
                  ),
                  TextButton(
                    child: Text(AppStrings.login),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, AppStrings.loginScreenRoute);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
