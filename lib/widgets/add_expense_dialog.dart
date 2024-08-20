import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/models/expense.dart';

class AddExpenseDialog extends StatefulWidget {
  const AddExpenseDialog({Key? key}) : super(key: key);

  @override
  State<AddExpenseDialog> createState() => _AddExpenseDialogState();
}

class _AddExpenseDialogState extends State<AddExpenseDialog> {
  final _amountController = TextEditingController();
  String _selectedCategory = 'Food';
  DateTime _selectedDate = DateTime.now();

  void _submitExpense (){
    final enteredAmount = double.tryParse(_amountController.text);
    if(enteredAmount == null || enteredAmount <=0){
      return;
    }
    final newExpense = Expense(
        amount: enteredAmount,
        category: _selectedCategory,
        date: _selectedDate
    );
    Provider.of<List<Expense>>(context, listen: false).add(newExpense);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Expense"),
      content: Column(
        children: [
          TextField(
            controller: _amountController,
            decoration: const InputDecoration(
              labelText: "Amount"
            ),
            keyboardType: TextInputType.number,
          ),
          DropdownButton<String>(
              value: _selectedCategory,
            onChanged: (newValue){
                setState(() {
                  _selectedCategory = newValue!;
                });
            },
            items: <String>["Food","Transport","shopping","Entertainment"].map<DropdownMenuItem<String>>((String value){
              return DropdownMenuItem<String>(
                value: value,
                  child: Text(value),
              );
            }).toList()
          ),
          TextButton(
              onPressed: () async {
                final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now()
                );
                if((pickedDate != null) && (pickedDate != _selectedDate)){
                  setState(() {
                    _selectedDate = pickedDate;
                  });
                }
              },
              child: Text("Select Date : ${_selectedDate.toLocal()}")
          )
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: _submitExpense,
            child: const Text("Add")
        )
      ],
    );
  }
}
