import 'package:flutter/material.dart';

class ExpenseTile extends StatelessWidget {
  final String title;
  final String amount;
  final DateTime datetime;

  const ExpenseTile({
    super.key,
    required this.title,
    required this.amount,
    required this.datetime,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(
        '${datetime.day}/${datetime.month}/${datetime.year}',
      ),
      trailing: Text('\$ $amount'),
    );
  }
}
