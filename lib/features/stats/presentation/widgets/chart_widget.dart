import 'dart:math';

import 'package:expense_tracker_app/core/constants/constants.dart';
import 'package:expense_tracker_app/features/add_transaction/domain/models/transaction_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({
    super.key,
    required this.transactions,
    required this.selectedType,
    required this.totalAmount,
  });

  final List<TransactionModel> transactions;
  final TransactionType selectedType;
  final double totalAmount;

  @override
  Widget build(BuildContext context) {
    final monthlyData = _buildMonthlyData();
    final maxValue = monthlyData.fold<double>(
      0,
      (prev, item) => max(prev, item.amount),
    );
    final maxY = _resolveMaxY(maxValue);
    final yInterval = _resolveInterval(maxY);
    final rangeLabel = _buildRangeLabel();

    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          rangeLabel,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 5),
        Text(
          "\$${totalAmount.toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          selectedType == TransactionType.income
              ? "Total income"
              : "Total expense",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 300,
          child: BarChart(
            BarChartData(
              maxY: maxY,
              barGroups: _barGroups(monthlyData, maxY),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: yInterval,
                    reservedSize: 48,
                    getTitlesWidget: (value, meta) {
                      if (value < 0) return const SizedBox.shrink();
                      return Text(
                        "\$${value.toStringAsFixed(0)}",
                        style: const TextStyle(fontSize: 12),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index < 0 || index >= monthlyData.length) {
                        return const SizedBox.shrink();
                      }
                      return Text(
                        monthlyData[index].label,
                        style: const TextStyle(fontSize: 12),
                      );
                    },
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(show: false),
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: ConstantsColors.black.withOpacity(0.7),
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final value = rod.toY;
                    return BarTooltipItem(
                      "\$${value.toStringAsFixed(2)}",
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                ),
              ),
            ),
            swapAnimationDuration: const Duration(milliseconds: 600),
            swapAnimationCurve: Curves.easeInOut,
          ),
        ),
        if (transactions.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              "No ${selectedType.name} transactions yet.",
              style: const TextStyle(fontSize: 14),
            ),
          ),
      ],
    );
  }

  List<_ChartPoint> _buildMonthlyData() {
    if (transactions.isEmpty) {
      final now = DateTime.now();
      return [_ChartPoint(label: DateFormat.MMM().format(now), amount: 0)];
    }

    final Map<DateTime, double> monthlyTotals = {};

    for (final transaction in transactions) {
      final monthKey = DateTime(transaction.date.year, transaction.date.month);
      monthlyTotals[monthKey] =
          (monthlyTotals[monthKey] ?? 0) + transaction.amount;
    }

    final sortedMonths = monthlyTotals.keys.toList()
      ..sort((a, b) => a.compareTo(b));

    // Keep last 8 months to match UI space
    final limitedMonths = sortedMonths.length > 8
        ? sortedMonths.sublist(sortedMonths.length - 8)
        : sortedMonths;

    return limitedMonths
        .map(
          (month) => _ChartPoint(
            label: DateFormat.MMM().format(month),
            amount: monthlyTotals[month] ?? 0,
          ),
        )
        .toList();
  }

  List<BarChartGroupData> _barGroups(List<_ChartPoint> data, double maxY) {
    return data.asMap().entries.map((entry) {
      return BarChartGroupData(
        x: entry.key,
        barRods: [
          BarChartRodData(
            toY: entry.value.amount,
            width: 18,
            gradient: const LinearGradient(
              colors: [
                ConstantsColors.primary,
                ConstantsColors.secondary,
                ConstantsColors.tertiary,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(8),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: maxY,
              color: Colors.grey.withOpacity(0.15),
            ),
          ),
        ],
      );
    }).toList();
  }

  String _buildRangeLabel() {
    if (transactions.isEmpty) {
      return "No data yet";
    }
    final sorted = List<TransactionModel>.from(transactions)
      ..sort((a, b) => a.date.compareTo(b.date));
    final formatter = DateFormat('dd MMM yyyy');
    return "${formatter.format(sorted.first.date)} - ${formatter.format(sorted.last.date)}";
  }

  double _resolveMaxY(double maxValue) {
    if (maxValue <= 0) return 1000;
    return maxValue * 1.2;
  }

  double _resolveInterval(double maxY) {
    if (maxY <= 0) return 200;
    final roughStep = maxY / 4;
    // Round to nearest 100 for cleaner ticks
    return (roughStep / 100).ceil() * 100;
  }
}

class _ChartPoint {
  _ChartPoint({required this.label, required this.amount});

  final String label;
  final double amount;
}
