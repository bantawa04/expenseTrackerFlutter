import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

//Positional argument
  Chart(this.recentTransactions);

//getter => dinamically calculated properties
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      //subtract days from today.
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum=0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      print(totalSum);
      print(DateFormat.E().format(weekDay));
      return {'Day': DateFormat.E().format(weekDay), 'Amount': totalSum};
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[],
      ),
    );
  }
}
