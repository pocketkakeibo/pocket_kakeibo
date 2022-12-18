import 'package:hive_flutter/hive_flutter.dart';

class Database {
  List expense = [];
  List categories = [];

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

    categories = [
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
  }

  void loadData() {
    expense = _localBox.get('expense');
    categories = _localBox.get('categories');
  }

  void updateDatabase() {
    _localBox.put('expense', expense);
    _localBox.put('categories', categories);
  }
}
