
import 'package:expense_tracker_app/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:expense_tracker_app/features/authentication/presentation/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePages;
  const LoginPage({super.key, required this.togglePages});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // auth cubit
  late final authCubit = context.read<AuthCubit>();

  // login method
  void login() {
    // prepare email and password
    final String email = emailController.text;
    final String password = passwordController.text;

    // check if not empty
    if (email.isNotEmpty && password.isNotEmpty) {
      // login
      authCubit.login(email, password);
    }
  }

  // forgot password box
  void openForgotPasswordBox() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Forgot Password?'),
          content: MyTextFormField(
            controller: emailController,
            hintText: 'email',
            emailOrPasswordOrUser: 'email',
          ),
          actions: [
            // cancel button
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: Colors.red)),
            ),

            // reset button
            TextButton(
              onPressed: () async {
                String message = await authCubit.forgotPassword(
                  emailController.text,
                );
                if (message == 'Password reset email! check your inbox.') {
                  Navigator.pop(context);
                  emailController.clear();
                }

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(message)));
              },
              child: Text('Reset', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.1),
                  Text(
                    "Login Account",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text("Login Account"),
                  SizedBox(height: size.height * 0.2),
                  // email
                  Text("EMAIL", style: TextStyle(fontSize: 20)),
                  SizedBox(height: size.height * 0.01),

                  MyTextFormField(
                    controller: emailController,
                    hintText: 'EMAIL',
                    emailOrPasswordOrUser: 'email',
                  ),
                  SizedBox(height: size.height * 0.02),

                  // password
                  Text("PASSWORD", style: TextStyle(fontSize: 20)),
                  SizedBox(height: size.height * 0.01),

                  MyTextFormField(
                    controller: passwordController,
                    hintText: "PASSWORD",
                    emailOrPasswordOrUser: 'password',
                  ),
                  SizedBox(height: size.height * 0.01),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(

                      onPressed: () => openForgotPasswordBox(),
                      child: Text('Forget password'),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  
                  TextButton(
                    onPressed: widget.togglePages,
                    child: Text(
                      'Don\'t have and account? Register.',
                      style: TextStyle(color: colorScheme.inversePrimary),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, proceed to login
                        login();
                      }
                    },
                    child: Text(
                      "LOGIN",
                      style: TextStyle(color: colorScheme.inversePrimary),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

