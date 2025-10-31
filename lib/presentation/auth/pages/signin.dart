import 'package:app_movie/common/helper/message/display_message.dart';
import 'package:app_movie/common/helper/navigation/app_navigation.dart';
import 'package:app_movie/core/configs/theme/app_colors.dart';
import 'package:app_movie/data/auth/models/signin_req_params.dart';
import 'package:app_movie/presentation/auth/bloc/auth_cubit.dart';
import 'package:app_movie/presentation/auth/bloc/auth_state.dart';
import 'package:app_movie/presentation/home/pages/home.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'signup.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController emailCon = TextEditingController();
  final TextEditingController passwordCon = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            DisplayMessage.successMessage(state.message, context);
            // Navigate to home page after successful sign in
            Future.delayed(const Duration(seconds: 1), () {
              AppNavigator.pushAndRemove(context, const HomePage());
            });
          } else if (state is AuthFailure) {
            DisplayMessage.errorMessage(state.errorMessage, context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              minimum: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80.0),
                    _signinText(),
                    const SizedBox(height: 24.0),
                    _emailField(emailCon),
                    const SizedBox(height: 16.0),
                    _passwordField(passwordCon),
                    const SizedBox(height: 24.0),
                    _submitButton(context, state, emailCon, passwordCon),
                    const SizedBox(height: 16.0),
                    _signupText(context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _signinText() {
    return const Text(
      "Sign In",
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _emailField(TextEditingController emailCon) {
    return TextField(
      controller: emailCon,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(color: Colors.black, fontSize: 16),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
        hintText: "Email",
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),

        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _passwordField(TextEditingController passwordCon) {
    return TextField(
      controller: passwordCon,
      obscureText: !_isPasswordVisible,
      style: const TextStyle(color: Colors.black, fontSize: 16),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
        hintText: "Password",
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),

        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _submitButton(
    BuildContext context,
    AuthState state,
    TextEditingController emailCon,
    TextEditingController passwordCon,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 5,
          overlayColor: Colors.transparent, // Remove red overlay when pressed
        ),
        onPressed: state is AuthLoading
            ? null
            : () {
                context.read<AuthCubit>().signIn(
                  SigninReqParams(
                    email: emailCon.text.trim(),
                    password: passwordCon.text,
                  ),
                );
              },
        child: state is AuthLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _signupText(BuildContext contextt) {
    return Text.rich(
      TextSpan(
        text: "Don't have an account? ",
        style: TextStyle(color: AppColors.textPrimary),
        children: [
          TextSpan(
            text: "Sign Up",
            style: TextStyle(
              color: AppColors.info,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                AppNavigator.push(contextt, SignupPage());
              },
          ),
        ],
      ),
    );
  }
}
