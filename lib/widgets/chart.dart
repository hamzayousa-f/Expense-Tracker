import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);
  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );
        double totalSum = 0.0;
        for (var i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].date?.day == weekDay.day &&
              recentTransactions[i].date?.month == weekDay.month &&
              recentTransactions[i].date?.year == weekDay.year) {
            totalSum += recentTransactions[i].amount!;
          }
        }

        return {
          'day': DateFormat.E().format(weekDay).substring(0, 1),
          'amount': totalSum,
        };
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransactionsValues.map((data) {
          return Text('${data['day']}: ${data['amount']}');
        }).toList(),
      ),
    );
  }
}
