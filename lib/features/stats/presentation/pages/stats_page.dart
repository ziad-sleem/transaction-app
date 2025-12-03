import 'package:expense_tracker_app/constants/constants.dart';
import 'package:expense_tracker_app/features/add_transaction/domain/models/transaction_model.dart';
import 'package:expense_tracker_app/features/home/presentation/cubit/transaction_cubit.dart';
import 'package:expense_tracker_app/features/stats/presentation/widgets/chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  TransactionType _selectedType = TransactionType.income;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Statistics",
                      style: TextStyle(
                        color: ConstantsColors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.settings_outlined),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _TypeSwitcher(
                  selected: _selectedType,
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value;
                    });
                  },
                ),
                const SizedBox(height: 24),
                BlocBuilder<TransactionCubit, TransactionState>(
                  builder: (context, state) {
                    if (state is TransactionLoading ||
                        state is TransactionInitial) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 80),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (state is TransactionError) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Text(
                          state.errorMessage,
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                      );
                    }
                    if (state is TransactionLoaded) {
                      final filtered = state.transactions
                          .where((t) => t.type == _selectedType)
                          .toList();
                      final total = _selectedType == TransactionType.income
                          ? state.income
                          : state.expense;

                      return SizedBox(
                        width: size.width,
                        child: ChartWidget(
                          transactions: filtered,
                          selectedType: _selectedType,
                          totalAmount: total,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TypeSwitcher extends StatelessWidget {
  const _TypeSwitcher({required this.selected, required this.onChanged});

  final TransactionType selected;
  final ValueChanged<TransactionType> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: ConstantsColors.white,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: ConstantsColors.primary.withOpacity(0.15)),
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
          _TypeSwitchTile(
            label: "Income",
            icon: Icons.south_west_rounded,
            isSelected: selected == TransactionType.income,
            onTap: () => onChanged(TransactionType.income),
          ),
          _TypeSwitchTile(
            label: "Expense",
            icon: Icons.north_east_rounded,
            isSelected: selected == TransactionType.expense,
            onTap: () => onChanged(TransactionType.expense),
          ),
        ],
      ),
    );
  }
}

class _TypeSwitchTile extends StatelessWidget {
  const _TypeSwitchTile({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? ConstantsColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(36),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? Colors.white : ConstantsColors.black,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : ConstantsColors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
