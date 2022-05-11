import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = new TextEditingController();
  final amountController = new TextEditingController();

  final Function addTransaction;

  NewTransaction(addTransaction);

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
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
            ),
            TextButton(
              onPressed: () {
                print(titleController.text);
                print(amountController.text);
              },
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
