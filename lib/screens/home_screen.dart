import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/add_expense_dialog.dart';
import '../widgets/expense_summary.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker"),
      ),
      body: Column(
        children: [
          Expanded(
              child: ExpenseSummary()
          ),
          ElevatedButton(
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (context) => AddExpenseDialog()
                );
              },
              child: const Text("Add Expense")
          )
        ],
      ),
    );
  }
}
