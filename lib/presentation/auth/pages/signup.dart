import 'package:app_movie/common/helper/navigation/app_navigation.dart';
import 'package:app_movie/core/configs/theme/app_colors.dart';
import 'package:app_movie/data/auth/models/signup_req_params.dart';
import 'package:app_movie/presentation/auth/bloc/auth_cubit.dart';
import 'package:app_movie/presentation/auth/bloc/auth_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'signin.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();
  final TextEditingController _confirmPasswordCon = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            // Navigate to sign in page after successful signup
            Future.delayed(const Duration(seconds: 1), () {
              AppNavigator.pushReplacement(context, const SigninPage());
            });
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
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
                    const SizedBox(height: 60.0),
                    _signupText(),
                    const SizedBox(height: 24.0),
                    _emailField(),
                    const SizedBox(height: 16.0),
                    _passwordField(),
                    const SizedBox(height: 16.0),
                    _confirmPasswordField(),
                    const SizedBox(height: 24.0),
                    _submitButton(context, state),
                    const SizedBox(height: 16.0),
                    _signinText(context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _signupText() {
    return const Text(
      "Sign Up",
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _emailField() {
    return TextField(
      controller: _emailCon,
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

  Widget _passwordField() {
    return TextField(
      controller: _passwordCon,
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

  Widget _confirmPasswordField() {
    return TextField(
      controller: _confirmPasswordCon,
      obscureText: !_isConfirmPasswordVisible,
      style: const TextStyle(color: Colors.black, fontSize: 16),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
        suffixIcon: IconButton(
          icon: Icon(
            _isConfirmPasswordVisible ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
            });
          },
        ),
        hintText: "Confirm Password",
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

  Widget _submitButton(BuildContext context, AuthState state) {
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
                context.read<AuthCubit>().signUp(
                  SignupReqParams(
                    email: _emailCon.text.trim(),
                    password: _passwordCon.text,
                    confirmPassword: _confirmPasswordCon.text,
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
                "Sign Up",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _signinText(BuildContext contextt) {
    return Text.rich(
      TextSpan(
        text: "Already have an account? ",
        style: TextStyle(color: AppColors.textPrimary),
        children: [
          TextSpan(
            text: "Sign in",
            style: TextStyle(
              color: AppColors.info,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                AppNavigator.push(contextt, const SigninPage());
              },
          ),
        ],
      ),
    );
  }
}
