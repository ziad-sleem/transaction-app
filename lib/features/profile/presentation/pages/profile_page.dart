import 'package:expense_tracker_app/core/constants/app_media_query.dart';
import 'package:expense_tracker_app/core/constants/constants.dart';
import 'package:expense_tracker_app/core/widgets/my_text.dart';
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
    final mq = MQ(context: context);
    final cubit = BlocProvider.of<AuthCubit>(context).currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: BlocBuilder<AuthCubit, AuthState>(
          bloc: BlocProvider.of<AuthCubit>(context),
          builder: (context, state) {
            if (cubit == null) {
              return Center(child: MyText("No user data available"));
            }

            final name = cubit.name;
            final email = cubit.email;
            final totalBalance = cubit.totalBalance;
            final income = cubit.income;
            final expense = cubit.expense;

            return SingleChildScrollView(
              child: Padding(
                padding: mq.paddingAll(mobile: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: mq.h5()),

                    // ---- PROFILE HEADER ----
                    Container(
                      padding: mq.paddingAll(mobile: 24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF8A3FFC), Color(0xFFFA4A84)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          // Avatar Circle
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.3),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                name.isNotEmpty ? name[0].toUpperCase() : "U",
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: mq.h2()),

                          // Name
                          MyText(
                            name,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          SizedBox(height: mq.h1()),

                          // Email
                          MyText(
                            email,
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: mq.h3()),

                    // ---- FINANCIAL SUMMARY ----
                    MyText(
                      "Financial Summary",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: ConstantsColors.black,
                    ),
                    SizedBox(height: mq.h2()),

                    // Total Balance Card
                    Container(
                      padding: mq.paddingAll(mobile: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ConstantsColors.tertiary,
                            ConstantsColors.secondary,
                            ConstantsColors.primary,
                          ],
                          transform: const GradientRotation(0.5),
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            "Total Balance",
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          SizedBox(height: mq.h1()),
                          MyText(
                            "\$${totalBalance.toStringAsFixed(2)}",
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: mq.h2()),

                    // Income and Expense Cards Row
                    Row(
                      children: [
                        // Income Card
                        Expanded(
                          child: Container(
                            padding: mq.paddingAll(mobile: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ConstantsColors.green
                                            .withOpacity(0.2),
                                      ),
                                      child: Icon(
                                        Icons.arrow_downward,
                                        color: ConstantsColors.green,
                                        size: 20,
                                      ),
                                    ),
                                    const Spacer(),
                                    MyText(
                                      "Income",
                                      fontSize: 12,
                                      color: ConstantsColors.gray,
                                    ),
                                  ],
                                ),
                                SizedBox(height: mq.h1()),
                                MyText(
                                  "\$${income.toStringAsFixed(2)}",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: ConstantsColors.black,
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(width: mq.w5()),

                        // Expense Card
                        Expanded(
                          child: Container(
                            padding: mq.paddingAll(mobile: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ConstantsColors.red.withOpacity(
                                          0.2,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.arrow_upward,
                                        color: ConstantsColors.red,
                                        size: 20,
                                      ),
                                    ),
                                    const Spacer(),
                                    MyText(
                                      "Expense",
                                      fontSize: 12,
                                      color: ConstantsColors.gray,
                                    ),
                                  ],
                                ),
                                SizedBox(height: mq.h1()),
                                MyText(
                                  "\$${expense.toStringAsFixed(2)}",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: ConstantsColors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: mq.h5()),

                    // ---- LOGOUT BUTTON ----
                    MyButton(
                      text: "Log Out",
                      onTap: () => context.read<AuthCubit>().logout(),
                    ),

                    SizedBox(height: mq.h2()),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
