import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = new TextEditingController();
  final amountController = new TextEditingController();

  final Function addTransaction;

  NewTransaction(this.addTransaction);

  void submit() {
    final title = titleController.text;
    final amount = double.parse(amountController.text); //typecasting

    if (title.isEmpty || amount <= 0) {
      return;
    }
    addTransaction(title, amount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              onSubmitted: (_) =>
                  {submit()}, // _ means I get value but don't plan to use it
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              keyboardType:
                  TextInputType.number, //use numberWithOptions(true) for IOS
              onSubmitted: (_) => {submit()},
            ),
            TextButton(
              onPressed: submit,
              child: Text(
                'Add Transaction',
                style: TextStyle(
                  color: Colors.purple,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
