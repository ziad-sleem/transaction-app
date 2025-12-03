import 'package:expense_tracker_app/constants/constants.dart';
import 'package:expense_tracker_app/features/add_transaction/presentation/cubit/add_transaction_cubit.dart';
import 'package:expense_tracker_app/features/add_transaction/presentation/pages/add_transaction_page.dart';
import 'package:expense_tracker_app/features/home/presentation/pages/home_page.dart';
import 'package:expense_tracker_app/features/home/presentation/cubit/transaction_cubit.dart';
import 'package:expense_tracker_app/features/profile/presentation/pages/profile_page.dart';
import 'package:expense_tracker_app/features/stats/presentation/pages/stats_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;
  static final List<Widget> _pages = [
    HomePage(),
    // We will provide AddTransactionCubit when navigating to AddTransactionPage
    AddTransactionPage(),
    StatsPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionCubit>(
      create: (context) => TransactionCubit()..getTransactions(),
      child: Scaffold(
        //! the page , IndexStack for make the pages load for one time not every time i nav to it
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            _pages[0], // HomePage
            BlocProvider(
              create: (context) => AddTransactionCubit(),
              child: _pages[1], // AddTransactionPage
            ),
            _pages[2], // StatsPage
            _pages[3], // ProfilePage
          ],
        ),
        //! the nav bar
        bottomNavigationBar: Container(
          color: ConstantsColors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
            child: GNav(
              backgroundColor: ConstantsColors.white,
              activeColor: ConstantsColors.white,
              color: ConstantsColors.primary,
              tabBackgroundColor: ConstantsColors.primary,
              padding: const EdgeInsetsGeometry.all(12),
              tabBackgroundGradient: LinearGradient(
                colors: [
                  ConstantsColors.tertiary,
                  ConstantsColors.secondary,
                  ConstantsColors.primary,
                ],
                transform: const GradientRotation(0.5),
              ),
              gap: 2,
              selectedIndex: _selectedIndex,
              onTabChange: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
              tabs: [
                GButton(icon: Icons.home_outlined, text: "Home"),
                GButton(icon: Icons.add, text: "Add"),
                GButton(icon: Icons.trending_up_outlined, text: "Stats"),
                GButton(icon: Icons.person_outline, text: "Profile"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
