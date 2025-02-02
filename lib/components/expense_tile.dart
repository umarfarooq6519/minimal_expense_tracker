import 'package:expense_tracker/utils/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String title;
  final String amount;
  final DateTime datetime;
  void Function(BuildContext)? deleteExpense;

  ExpenseTile({
    super.key,
    required this.title,
    required this.amount,
    required this.datetime,
    required this.deleteExpense,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteExpense,
              icon: Icons.delete,
              backgroundColor: Colors.red.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyles.baseHeading,
          ),
          subtitle: Text(
            '${datetime.day}/${datetime.month}/${datetime.year}',
            style: TextStyles.dimText,
          ),
          trailing: Text(
            '\$ $amount',
            style: TextStyles.baseText,
          ),
        ),
      ),
    );
  }
}
