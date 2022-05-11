import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './new_transaction.dart';
import './transaction_list.dart';

class UserTransaction extends StatefulWidget {
  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _userTransaction = [
    Transaction(
      id: "1",
      title: 'New Shose',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: "2",
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
  ];

  void _addTransaction(title, amount) {
    final tx = new Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );

    setState(() {
      _userTransaction.add(tx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addTransaction),
        TransactionList(_userTransaction),
      ],
    );
  }
}
