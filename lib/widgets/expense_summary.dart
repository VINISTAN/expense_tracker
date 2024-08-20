import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseSummary extends StatelessWidget {
  const ExpenseSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final expenses = Provider.of<List<Expense>>(context);
    final expenseSummary = _calculatedSummary(expenses);
    return ListView.builder(
        itemCount: expenseSummary.keys.length,
      itemBuilder: (ctx, index){
          final category = expenseSummary.keys.elementAt(index);
        final totalAmount = expenseSummary[category];

          return ListTile(
        title: Text(category),
        trailing: Text(""),
        );
      },

    );
  }
  Map<String, double> _calculatedSummary (List<Expense> expenses){
    final summary = <String, double> {};
    for ( var expense in expenses){
      if (!summary.containsKey(expense.category)) {
        summary[expense.category] = 0.0;
      }
      summary [expense.category] = summary[expense.category]! + expense.amount;
    }
    return summary;
  }
}
