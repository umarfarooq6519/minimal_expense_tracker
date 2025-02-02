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
        title: const Text('Add New Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // expense name
            TextField(
              decoration: const InputDecoration(
                hintText: 'Title',
              ),
              controller: _expenseNameController,
            ),

            // expense amount
            TextField(
              keyboardType: const TextInputType.numberWithOptions(),
              decoration: const InputDecoration(
                hintText: 'Amount',
              ),
              controller: _expenseAmountController,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: save,
            child: const Text('Save'),
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
    // create expense item
    Expense newExpense = Expense(
      title: _expenseNameController.text,
      amount: _expenseAmountController.text,
      dateTime: DateTime.now(),
    );

    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);

    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
  }

  void clear() {
    _expenseAmountController.clear();
    _expenseNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[200],

        // content
        body: SafeArea(
          child: ListView(
            children: [
              // weekly summary
              ExpenseSummary(startOfWeek: value.startOfWeekDay()),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getOverallExpenseList().length,
                itemBuilder: (context, index) => ExpenseTile(
                  title: value.getOverallExpenseList()[index].title,
                  amount: value.getOverallExpenseList()[index].amount,
                  datetime: value.getOverallExpenseList()[index].dateTime,
                ),
              ),
            ],
          ),
        ),

        // floating add button
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: showAddDialog,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
