import 'package:expense_tracker/bar%20graph/bar_graph.dart';
import 'package:expense_tracker/data/expense.data.dart';
import 'package:expense_tracker/helpers/datetime.helper.dart';
import 'package:expense_tracker/utils/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime? startOfWeek;

  const ExpenseSummary({
    super.key,
    required this.startOfWeek,
  });

  double calculateMax(ExpenseData value, String sun, String mon, String tue,
      String wed, String thu, String fri, String sat) {
    double? max = 100;

    List<double> values = [
      value.calculateDailyExpenseSummary()[sun] ?? 0,
      value.calculateDailyExpenseSummary()[mon] ?? 0,
      value.calculateDailyExpenseSummary()[tue] ?? 0,
      value.calculateDailyExpenseSummary()[wed] ?? 0,
      value.calculateDailyExpenseSummary()[thu] ?? 0,
      value.calculateDailyExpenseSummary()[fri] ?? 0,
      value.calculateDailyExpenseSummary()[sat] ?? 0,
    ];

    values.sort(); // from smallest to largest

    // get largest amount and increase the cap slightly
    // so the graph looks almost full
    max = values.last * 1.1;

    return max == 0 ? 100 : max;
  }

  String calculateWeekTotal(ExpenseData value, String sun, String mon,
      String tue, String wed, String thu, String fri, String sat) {
    List<double> values = [
      value.calculateDailyExpenseSummary()[sun] ?? 0,
      value.calculateDailyExpenseSummary()[mon] ?? 0,
      value.calculateDailyExpenseSummary()[tue] ?? 0,
      value.calculateDailyExpenseSummary()[wed] ?? 0,
      value.calculateDailyExpenseSummary()[thu] ?? 0,
      value.calculateDailyExpenseSummary()[fri] ?? 0,
      value.calculateDailyExpenseSummary()[sat] ?? 0,
    ];

    double total = 0;

    for (var value in values) {
      total += value;
    }

    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    String sunday =
        convertDateTimeToString(startOfWeek!.add(const Duration(days: 0)));
    String monday =
        convertDateTimeToString(startOfWeek!.add(const Duration(days: 1)));
    String tuesday =
        convertDateTimeToString(startOfWeek!.add(const Duration(days: 2)));
    String wednesday =
        convertDateTimeToString(startOfWeek!.add(const Duration(days: 3)));
    String thursday =
        convertDateTimeToString(startOfWeek!.add(const Duration(days: 4)));
    String friday =
        convertDateTimeToString(startOfWeek!.add(const Duration(days: 5)));
    String saturday =
        convertDateTimeToString(startOfWeek!.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                const Text(
                  'Week Total:',
                  style: TextStyles.mediumHeading,
                ),
                const SizedBox(width: 4),
                Text(
                  '\$${calculateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}',
                  style: TextStyles.baseText,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: MyBarGraph(
              maxY: 100,
              sunAmount: value.calculateDailyExpenseSummary()[sunday] ?? 0,
              monAmount: value.calculateDailyExpenseSummary()[monday] ?? 0,
              tueAmount: value.calculateDailyExpenseSummary()[tuesday] ?? 0,
              wedAmount: value.calculateDailyExpenseSummary()[wednesday] ?? 0,
              thuAmount: value.calculateDailyExpenseSummary()[thursday] ?? 0,
              friAmount: value.calculateDailyExpenseSummary()[friday] ?? 0,
              satAmount: value.calculateDailyExpenseSummary()[saturday] ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
