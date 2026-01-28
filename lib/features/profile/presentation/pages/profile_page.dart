import 'package:expense_tracker_app/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:expense_tracker_app/features/authentication/presentation/cubit/auth_state.dart';
import 'package:expense_tracker_app/features/transaction%20details/presentation/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context).currentUser;
    final name = cubit!.name;
    final email = cubit.email;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // ---- NAME ----
              BlocBuilder<AuthCubit, AuthState>(
                bloc: BlocProvider.of<AuthCubit>(context),
                builder: (context, state) {
                  return Column(
                    children: [
                      _gradientText(name, size: 28, weight: FontWeight.w700),

                      const SizedBox(height: 8),

                      // ---- EMAIL ----
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  );
                },
              ),

              const Spacer(),

              // ---- LOGOUT BUTTON ----
              MyButton(
                text: "Log Out",
                onTap: () => context.read<AuthCubit>().logout(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---- GRADIENT TEXT ----
  Widget _gradientText(
    String text, {
    double size = 20,
    FontWeight weight = FontWeight.w600,
  }) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Color(0xFF8A3FFC), Color(0xFFFA4A84)],
      ).createShader(bounds),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: size,
          fontWeight: weight,
        ),
      ),
    );
  }

  // ---- INFO CARD ----
  Widget _infoCard({required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            "$title:",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const Spacer(),
          _gradientText(value, size: 16),
        ],
      ),
    );
  }
}
