import 'package:hive_flutter/hive_flutter.dart';

class Database {
  List expense = [];
  List income = [];
  List exCategories = [];
  List inCategories = [];

  final _localBox = Hive.box('localBox');

  void createInitialData() {
    expense = [
      {
        'name': 'Food',
        'price': 100000,
        'category': 'Survival',
        'date': DateTime.now(),
      },
      {
        'name': 'Bensin',
        'price': 100000,
        'category': 'Survival',
        'date': DateTime.now(),
      },
      {
        'name': 'Service Motor',
        'price': 300000,
        'category': 'Extra',
        'date': DateTime.now(),
      },
      {
        'name': 'Movie Tickets',
        'price': 45000,
        'category': 'Optional',
        'date': DateTime.now(),
      },
      {
        'name': 'Online Course',
        'price': 150000,
        'category': 'Culture',
        'date': DateTime.now(),
      }
    ];

    income = [
      {
        'name': 'Job',
        'price': 7000000,
        'category': 'Active',
        'date': DateTime.now(),
      },
      {
        'name': 'Stock',
        'price': 3000000,
        'category': 'Passive',
        'date': DateTime.now(),
      },
    ];

    exCategories = [
      {
        'name': 'Survival',
        'total': 200000,
      },
      {
        'name': 'Optional',
        'total': 45000,
      },
      {
        'name': 'Culture',
        'total': 150000,
      },
      {
        'name': 'Extra',
        'total': 300000,
      },
    ];

    inCategories = [
      {
        'name': 'Active',
        'total': 7000000,
      },
      {
        'name': 'Passive',
        'total': 3000000,
      },
    ];
  }

  void loadData() {
    expense = _localBox.get('expense');
    income = _localBox.get('income');
    exCategories = _localBox.get('exCategories');
    inCategories = _localBox.get('inCategories');
  }

  void updateDatabase() {
    _localBox.put('expense', expense);
    _localBox.put('income', income);
    _localBox.put('exCategories', exCategories);
    _localBox.put('inCategories', inCategories);
  }
}
