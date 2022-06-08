import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        // accentColor: Colors.amber,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              //theme for other title text
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              //theme for button text color
              button: TextStyle(
                color: Colors.white,
              ),
            ),
        appBarTheme: AppBarTheme(
          //theme for app bar
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;
  final List<Transaction> _userTransaction = [
    Transaction(
      id: "1",
      title: 'New Shose',
      amount: 69.99,
      date: DateTime.now().subtract(Duration(days: 7)),
    ),
    Transaction(
      id: "2",
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now().subtract(Duration(days: 6)),
    ),
    Transaction(
      id: "2",
      title: 'New Jacket',
      amount: 20.99,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: "2",
      title: 'Mobile Phone',
      amount: 600,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: "2",
      title: 'Restaurant Bill',
      amount: 40.99,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: "2",
      title: 'Gas',
      amount: 10.20,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: "2",
      title: 'Internet Bill',
      amount: 20.20,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
  ];

//getter
  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date!.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

//
// Add new transaction
//
  void _addTransaction(String title, double amount, DateTime selectedDate) {
    final tx = new Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: selectedDate,
    );

    setState(() {
      _userTransaction.add(tx);
    });
  }

//show/hide add transaction modal
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addTransaction);
        });
  }

  void _deleteTransation(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('Personal Expense'),
      actions: <Widget>[
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: Icon(
            Icons.add,
          ),
        ),
      ],
    );

    final txListWidget = Container(
      //remove appbar and status bar height
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransactionList(_userTransaction, _deleteTransation),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /** Show in landscape mode start */
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart'),
                  Switch(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      }),
                ],
              ),
            if (isLandscape)
              _showChart
                  ? Container(
                      //remove appbar and status bar height
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Chart(_recentTransactions),
                    )
                  : txListWidget,
            /** Show in landscape mode end */
            /** Show in portrait mode start */
            if (!isLandscape)
              Container(
                //remove appbar and status bar height
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(_recentTransactions),
              ),
            if (!isLandscape) txListWidget,
            /** Show in portrait mode end */
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
