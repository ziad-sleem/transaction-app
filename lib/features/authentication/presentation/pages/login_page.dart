import 'package:expense_tracker_app/core/constants/app_media_query.dart';
import 'package:expense_tracker_app/core/constants/constants.dart';
import 'package:expense_tracker_app/core/widgets/my_text.dart';
import 'package:expense_tracker_app/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:expense_tracker_app/features/authentication/presentation/widgets/auth_panar.dart';
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
          title: MyText('Forgot Password?'),
          content: MyTextFormField(
            controller: emailController,
            hintText: 'email',
            emailOrPasswordOrUser: 'email',
          ),
          actions: [
            // cancel button
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: MyText('Cancel', color: Colors.red),
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
                ).showSnackBar(SnackBar(content: MyText(message)));
              },
              child: MyText('Reset', color: Colors.green),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final mq = MQ(context: context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: mq.h10()),
                  AuthPanar(),
                  SizedBox(height: mq.h20(mobileMultiplier: 0.18)),
                  // email
                  MyText("EMAIL", fontSize: 20),
                  SizedBox(height: mq.h1()),

                  MyTextFormField(
                    controller: emailController,
                    hintText: 'EMAIL',
                    emailOrPasswordOrUser: 'email',
                  ),
                  SizedBox(height: mq.h2()),

                  // password
                  MyText("PASSWORD", fontSize: 20),
                  SizedBox(height: mq.h1()),

                  MyTextFormField(
                    controller: passwordController,
                    hintText: "PASSWORD",
                    emailOrPasswordOrUser: 'password',
                  ),
                  SizedBox(height: mq.h1()),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () => openForgotPasswordBox(),
                      child: MyText('Forget password'),
                    ),
                  ),
                  SizedBox(height: mq.h3()),

                  TextButton(
                    onPressed: widget.togglePages,
                    child: MyText(
                      'Don\'t have and account? Register.',
                      color: colorScheme.primary,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, proceed to login
                        login();
                      }
                    },
                    child: MyText("LOGIN", color: ConstantsColors.secondary),
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
