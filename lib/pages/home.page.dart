import 'package:expense_tracker/utils/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expense_tracker/components/expense_summary.dart';
import 'package:expense_tracker/components/expense_tile.dart';
import 'package:expense_tracker/data/expense.data.dart';
import 'package:expense_tracker/models/expense.model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _expenseNameController = TextEditingController();
  final _expenseAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // prepare the expenses data
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  void showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'New Expense',
          style: TextStyles.largeHeading,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // expense name
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.title_rounded),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 40,
                  minHeight: 0,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(17),
                  ),
                ),
                hintText: 'Title',
              ),
              controller: _expenseNameController,
            ),

            const SizedBox(height: 8),

            // expense amount
            TextField(
              keyboardType: const TextInputType.numberWithOptions(),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(17),
                  ),
                ),
                prefixIcon: Icon(Icons.attach_money_rounded),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 40,
                  minHeight: 0,
                ),
                hintText: 'Amount',
              ),
              controller: _expenseAmountController,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.black87,
            ),
            onPressed: save,
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: cancel,
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void save() {
    // only save when input not empty
    if (_expenseNameController.text.isNotEmpty &&
        _expenseAmountController.text.isNotEmpty) {
      // create expense item
      Expense newExpense = Expense(
        title: _expenseNameController.text,
        amount: _expenseAmountController.text,
        dateTime: DateTime.now(),
      );

      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
    }

    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
  }

  void delete(Expense expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  void clear() {
    _expenseAmountController.clear();
    _expenseNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        // content
        body: SafeArea(
          child: ListView(
            children: [
              // weekly summary
              ExpenseSummary(startOfWeek: value.startOfWeekDay()),

              const SizedBox(height: 20),

              // expenses list
              _expensesList(value),
            ],
          ),
        ),

        // floating add button
        floatingActionButton: _floatingButton(),
      ),
    );
  }

  FloatingActionButton _floatingButton() {
    return FloatingActionButton(
      backgroundColor: Colors.black87,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      onPressed: showAddDialog,
      child: Icon(
        Icons.add,
        color: Colors.grey[200],
      ),
    );
  }

  ListView _expensesList(ExpenseData value) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: value.getOverallExpenseList().length,
      itemBuilder: (context, index) => ExpenseTile(
        title: value.getOverallExpenseList()[index].title,
        amount: value.getOverallExpenseList()[index].amount,
        datetime: value.getOverallExpenseList()[index].dateTime,
        deleteExpense: (context) =>
            delete(value.getOverallExpenseList()[index]),
      ),
    );
  }
}
