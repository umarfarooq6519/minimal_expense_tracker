import 'package:flutter/material.dart';

import 'package:expense_tracker/data/hive.data.dart';
import 'package:expense_tracker/helpers/datetime.helper.dart';
import 'package:expense_tracker/models/expense.model.dart';

class ExpenseData extends ChangeNotifier {
  // list of all expenses
  List<Expense> overallExpenseList = [];

  // get expense list
  List<Expense> getOverallExpenseList() {
    return overallExpenseList;
  }

  final db = HiveDatabase();
  // prepare data to display
  void prepareData() {
    if (db.readData().isNotEmpty) {
      overallExpenseList = db.readData();
    }
  }

  // add new expense
  void addNewExpense(Expense expense) {
    overallExpenseList.add(expense);

    notifyListeners();
    db.saveData(overallExpenseList);
  }

  // delete expense
  void deleteExpense(Expense expense) {
    overallExpenseList.remove(expense);

    notifyListeners();
    db.saveData(overallExpenseList);
  }

  // get weekday (mon tue etc) from a datetime object
  String getDayName(DateTime datetime) {
    switch (datetime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';

      default:
        return '';
    }
  }

  // get the date for the start of the week (sunday)
  DateTime? startOfWeekDay() {
    DateTime? startOfWeek;

    // get todays date
    DateTime? today = DateTime.now();

    // go backwards to find sunday (start of week)
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek;
  }

  /* 
  
  DailyExpenseSummary:
  
  [
    [20230130, $25],
    [20230130, $10],
    [20230130, $5],
    [20230130, $32],
    [20230130, $16],
  ] 

  */

  // convert overall list of expenses into daily expense summary
  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {
      // date (yyyymmdd) : amountTotalForDay
    };

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;

        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }

    return dailyExpenseSummary;
  }
}
