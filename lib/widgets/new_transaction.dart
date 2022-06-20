import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = new TextEditingController();
  final _amountController = new TextEditingController();
  DateTime? _selectedDate;

  void _submit() {
    final title = _titleController.text;
    final amount = double.parse(_amountController.text); //typecasting

    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTransaction(title, amount, _selectedDate);
    //close outmost layer
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                onSubmitted: (_) =>
                    {_submit()}, // _ means I get value but don't plan to use it
              ),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                keyboardType:
                    TextInputType.number, //use numberWithOptions(true) for IOS
                onSubmitted: (_) => {_submit()},
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No date selected'
                            : 'Picked Date:${DateFormat.yMd().format(_selectedDate as DateTime)}',
                      ),
                    ),
                    TextButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        'Select date',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submit,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: TextButton.styleFrom(
                  primary: Theme.of(context).textTheme.button!.color,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
