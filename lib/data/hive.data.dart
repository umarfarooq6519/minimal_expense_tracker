import 'package:hive_flutter/hive_flutter.dart';
import 'package:expense_tracker/models/expense.model.dart';

class HiveDatabase {
  // reference our box
  final _myBox = Hive.box('expenses_db');

  // #### write data
  void saveData(List<Expense> allExpenses) {
    /*
    Hive can only store basic data types, not custom types like ExpenseItem.
    So we have to first convert ExpenseItem to other datatypes for our db

    allExpense = 
    [
      ExpenseItem (title, amount, dateTime)
      ..
    ]
    --> 
    [
      [title, amount, dateTime]
      ..
    ]

    */

    List<List<dynamic>> allExpenseseFormatted = [];

    for (var expense in allExpenses) {
      // convert each expense item into storable types (strings & dateTime)
      List<dynamic> expenseFormatted = [
        expense.title,
        expense.amount,
        expense.dateTime,
      ];
      allExpenseseFormatted.add(expenseFormatted);
    }

    _myBox.put('all_expenses', allExpenseseFormatted);
  }

  // #### read data
  List<Expense> readData() {
    /*
      Data is stored in Hive as strings and dateTime,
      now let's convert it back to ExpenseItem objects

      savedData = 
      [
        [ title, amount, dateTime ]
        ..
      ]
      -->
      [
        ExpenseItem (title, amount, dateTime)
        ..
      ]
     */

    List savedExpenses = _myBox.get('all_expenses') ?? [];
    List<Expense> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      // collect individual expense data
      String title = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      // create expense item
      Expense expense = Expense(
        title: title,
        amount: amount,
        dateTime: dateTime,
      );

      // add expense to overall list of expenses
      allExpenses.add(expense);
    }
    return allExpenses;
  }
}
