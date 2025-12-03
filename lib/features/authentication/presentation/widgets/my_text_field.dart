import 'package:expense_tracker_app/constants/constants.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final String emailOrPasswordOrUser;
  const MyTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.emailOrPasswordOrUser,
  });

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.emailOrPasswordOrUser == 'password';
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter ${widget.emailOrPasswordOrUser}';
        }
        if (widget.emailOrPasswordOrUser == 'email') {
          // Robust email regex
          final emailRegex = RegExp(
            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
          );
          if (!emailRegex.hasMatch(value)) {
            return 'Please enter a valid email address';
          }
        } else if (widget.emailOrPasswordOrUser == 'password') {
          // Password: min 8 chars, can be only numbers or any characters
          if (value.length < 8) {
            return 'Password must be at least 8 characters';
          }
        } else if (widget.emailOrPasswordOrUser == 'user') {
          if (value.isEmpty) {
            return 'Please enter an user name';
          }
        }
        return null;
      },
      controller: widget.controller,
      obscureText: isPassword ? _obscurePassword : false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.emailOrPasswordOrUser == 'email'
            ? Icon(Icons.email)
            : widget.emailOrPasswordOrUser == 'password'
            ? Icon(Icons.password_outlined)
            : widget.emailOrPasswordOrUser == 'user'
            ? Icon(Icons.person)
            : Icon(Icons.abc_outlined),
        prefixIconColor: ConstantsColors.secondary,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20), // adjust as needed
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(16),
        ),
        // Add show/hide password icon for password fields
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: ConstantsColors.secondary,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              )
            : null,
      ),
    );
  }
}
