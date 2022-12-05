import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ExpenseCard extends StatelessWidget {
  final String name;
  final int price;
  final String category;
  final DateTime date;
  Function(BuildContext)? onEdit;
  Function(BuildContext)? onDelete;

  ExpenseCard({
    super.key,
    required this.name,
    required this.price,
    required this.category,
    required this.date,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SizedBox(width: 8),
            SlidableAction(
              onPressed: onEdit,
              icon: Icons.edit,
              backgroundColor: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            SizedBox(width: 8),
            SlidableAction(
              onPressed: onDelete,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Card(
          child: Align(
            alignment: Alignment.centerRight,
            child: ListTile(
              leading: Text(category),
              title: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      Text(
                        NumberFormat.currency(
                          locale: 'id_ID',
                          symbol: 'Rp. ',
                          decimalDigits: 0,
                        ).format(price),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(DateFormat('dd MMMM yyyy').format(date)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
