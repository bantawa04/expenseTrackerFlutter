import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
          vertical:
              8), //add margin to defined axis vertical or horizontal
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).primaryColor,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                '\$${transaction.amount!.toStringAsFixed(2)}',
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title!,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date!),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
                onPressed: (() => deleteTx(transaction.id)),
                icon: Icon(Icons.delete,
                    color: Theme.of(context).errorColor),
                label: Text(
                  'Delete',
                  style:
                      TextStyle(color: Theme.of(context).errorColor),
                ))
            : IconButton(
                onPressed: (() => deleteTx(transaction.id)),
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
              ),
      ),
    );
  }
}
