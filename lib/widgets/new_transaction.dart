import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/widgets/adaptive_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction){
    print("New transaction constructor");
  }

  @override
  _NewTransactionState createState() {
    print("Create state");
    return _NewTransactionState();
  } 
}

class _NewTransactionState extends State<NewTransaction> {
  
 _NewTransactionState(){
  print("Constructor of state");
 }

  @override
  void initState() {
    print("Initialize state");
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    print("Widget updated");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print("widget disposed");
    super.dispose();
  }
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
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                onSubmitted: (_) =>
                    {_submit()}, // _ means I get value but don't plan to use it
              ),
              TextField(
                controller: _amountController,
                decoration: const InputDecoration(
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
                    AdaptiveButton('Choose Date', _presentDatePicker),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submit,
                child: const Text(
                  'Add Transaction',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style:  TextButton.styleFrom(
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
