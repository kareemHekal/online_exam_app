import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/Shared/widgets/Validator.dart';
import 'package:online_exam_app/Shared/widgets/custom_button.dart';
import 'package:online_exam_app/Shared/widgets/custom_password_text_field.dart';
import 'package:online_exam_app/Shared/widgets/custom_text_field.dart';
import 'package:online_exam_app/core/utils/config.dart';
import 'package:online_exam_app/core/utils/string_manager.dart';
import 'package:online_exam_app/ui/Auth/view_model/cubit/auth_cubit.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isChecked = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _validateAndLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().login(
          email: emailController.text,
          password: passwordController.text,
          rememberMe: isChecked);
    }
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.pushReplacementNamed(context, AppStrings.homeScreenRoute);
        }
        if (state is LoginErrorState) {
          print(state.message);
        }
      },
      child: Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              AppStrings.login,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: false,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: Config.screenHight! * 0.01),

                /* Email Field */
                CustomTextField(
                  label: AppStrings.email,
                  placeholder: AppStrings.enterYourEmail,
                  controller: emailController,
                  validator: Validator.email,
                ),
                SizedBox(height: 30),

                /* Password Field */
                CustomPasswordField(
                  label: AppStrings.password,
                  controller: passwordController,
                  validator: Validator.password,
                ),
                SizedBox(height: 20),

                /* Remember Me & Forget Password */
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: Color(0xff02369C),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Text(
                        AppStrings.rememberMe,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w400),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context,
                                AppStrings.enterEmailForgetPasswordScreenRoute);
                          },
                          child: Text(
                            AppStrings.forgetpassword,
                            style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.black,
                              decorationThickness: 2,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),

                /* Login Button */
                CustomButton(
                    onTap: () => _validateAndLogin(context),
                    text: AppStrings.login),
                SizedBox(height: 20),

                /* Sign Up Option */
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.dontHaveAccount,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, AppStrings.singUpScreenRoute);
                        },
                        child: Text(
                          AppStrings.signUp,
                          style: TextStyle(
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blueAccent,
                            decorationThickness: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
