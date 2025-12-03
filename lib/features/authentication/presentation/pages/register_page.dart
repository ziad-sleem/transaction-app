
import 'package:expense_tracker_app/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:expense_tracker_app/features/authentication/presentation/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePages;
  const RegisterPage({super.key, required this.togglePages});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // sign up
  void signUp() {
    // prepare name and email and password
    final String name = userNameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;

    // auth cubit
    final authCubit = context.read<AuthCubit>();

    // check if not empty
    if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      // sign up
      authCubit.register(name, email, password);
    }
    // fields are empty => display error
    else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please complete all fields')));
    }
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                  SizedBox(height: size.height * 0.1),
                  Text(
                    "Create Account",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text("Create Account", style: TextStyle()),
                  SizedBox(height: size.height * 0.18),
                  // email
                  Text("NAME", style: TextStyle(fontSize: 20)),
                  SizedBox(height: size.height * 0.01),

                  MyTextFormField(
                    controller: userNameController,
                    hintText: 'NAME',
                    emailOrPasswordOrUser: 'user',
                  ),
                  SizedBox(height: size.height * 0.02),
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
                  SizedBox(height: size.height * 0.1),
                  TextButton(
                    onPressed: widget.togglePages,
                    child: Text(
                      "Already have an account, loing here",
                      style: TextStyle(color: theme.inversePrimary),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        signUp();
                      }
                    },
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(color: theme.inversePrimary),
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
