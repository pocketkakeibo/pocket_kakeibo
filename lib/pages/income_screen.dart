import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pocket_kakeibo/components/dialog_modal.dart';
import 'package:pocket_kakeibo/components/income_card.dart';
import 'package:pocket_kakeibo/data/database.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({super.key});

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  final _localBox = Hive.box('localBox');
  Database db = Database();

  @override
  void initState() {
    _localBox.clear();
    if (_localBox.get('income') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  void editIncome(int index) {
    showDialog(
      context: context,
      builder: (context) {
        _controllers[0].text = db.income[index]['name'];
        _controllers[1].text = db.income[index]['price'];
        _controllers[2].text = db.income[index]['category'];
        _controllers[3].text = db.income[index]['date'];
        return DialogModal(
          controllers: _controllers,
          onSave: () {
            db.income[index]['name'] = _controllers[0].text;
            db.income[index]['price'] = _controllers[1].text;
            db.income[index]['category'] = _controllers[2].text;
            db.income[index]['date'] = _controllers[3].text;
            db.updateDatabase();
            Navigator.pop(context);
            setState(() {});
          },
          onCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void createNewincome() {
    _controllers[0].text = '';
    _controllers[1].text = '';
    _controllers[2].text = '';
    _controllers[3].text = '';
    showDialog(
        context: context,
        builder: (context) {
          return DialogModal(
            controllers: _controllers,
            onSave: saveNewIncome,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
    db.updateDatabase();
  }

  void deleteincome(int index) {
    setState(() {
      db.income.removeAt(index);
    });
    db.updateDatabase();
  }

  void saveNewIncome() {
    setState(() {
      db.income.add({
        "name": _controllers[0].text,
        "price": int.parse(_controllers[1].text),
        "category":
            _controllers[2].text.isEmpty ? "Survival" : _controllers[2].text,
        "date": _controllers[3].text.isEmpty
            ? DateTime.now()
            : DateTime.parse(_controllers[3].text)
      });
      Navigator.of(context).pop();
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange[200],
        floatingActionButton: FloatingActionButton(
          onPressed: createNewincome,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
          padding: EdgeInsets.only(bottom: 100),
          itemCount: db.income.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Expanded(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/cat.png',
                          width: 300,
                        ),
                        Text(
                          'Good Morning!',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.orange,
                            fontSize: 30.0,
                          ),
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                    IncomeCard(
                      name: db.income[index]['name'],
                      price: db.income[index]['price'],
                      category: db.income[index]['category'],
                      date: db.income[index]['date'],
                      onDelete: (context) => deleteincome(index),
                      onEdit: (context) => editIncome(index),
                    ),
                  ],
                ),
              );
            } else {
              return IncomeCard(
                name: db.income[index]['name'],
                price: db.income[index]['price'],
                category: db.income[index]['category'],
                date: db.income[index]['date'],
                onDelete: (context) => deleteincome(index),
                onEdit: (context) => editIncome(index),
              );
            }
          },
        ));
  }
}
