import 'package:expense_tracker_app/features/authentication/data/firebase_auth_repo.dart';
import 'package:expense_tracker_app/features/authentication/domain/repos/auth_repo.dart';
import 'package:expense_tracker_app/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:expense_tracker_app/features/authentication/presentation/cubit/auth_state.dart';
import 'package:expense_tracker_app/features/authentication/presentation/pages/auth_page.dart';
import 'package:expense_tracker_app/features/navigation_bar_page.dart/presentation/pages/navigation_page.dart';
import 'package:expense_tracker_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final AuthRepo authRepo = FirebaseAuthRepo();
        final cubit = AuthCubit(authRepo: authRepo);
        // Check authentication state when app starts
        cubit.checkAuth();
        return cubit;
      },
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: BlocConsumer<AuthCubit, AuthState>(
              builder: (context, state) {
                // unauthenticated => auth page
                if (state is Unauthenticated) {
                  return const AuthPage();
                }
                // authenticated => home page
                else if (state is Authenticated) {
                  return NavigationPage();
                }
                // loading
                else if (state is AuthLoading) {
                  return Scaffold(
                    body: Center(child: CircularProgressIndicator.adaptive()),
                  );
                } else {
                  // Show a loading indicator for initial or any unexpected state
                  return Scaffold(
                    body: Center(child: CircularProgressIndicator.adaptive()),
                  );
                }
              },
              listener: (context, state) {
                if (state is AuthError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
                }
              },
            ),
          );
        },
      ),
    );
  }
}
