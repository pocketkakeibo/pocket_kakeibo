import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pocket_kakeibo/components/func_button.dart';

class DialogModal extends StatefulWidget {
  final controllers;
  String category = "Survival";
  DateTime dateText = DateTime.now();
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogModal({
    super.key,
    required this.controllers,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<DialogModal> createState() => _DialogModalState();
}

class _DialogModalState extends State<DialogModal> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.white,
        content: Container(
            height: 500,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    controller: widget.controllers[0],
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Expense Name",
                    ),
                  ),
                  TextField(
                    controller: widget.controllers[1],
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Total Price",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  // a Dropdown Widget with controllers[2] that has a list of strings ["Survival", "Optional", "Extra", "Culture"]
                  DropdownButton<String>(
                    isExpanded: true,
                    value: widget.category,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    onChanged: (String? newValue) {
                      setState(() {
                        widget.category = newValue!;
                        widget.controllers[2].text = widget.category;
                      });
                    },
                    items: <String>["Survival", "Optional", "Extra", "Culture"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat('dd MMMM yyyy').format(widget.dateText)),
                      IconButton(
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: widget.dateText,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          ).then((value) {
                            setState(() {
                              widget.dateText = DateTime.parse(value.toString());
                              widget.controllers[3].text = value.toString();
                            });
                          });
                        },
                        icon: const Icon(Icons.date_range),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FuncButton(text: 'Save', onPressed: widget.onSave),
                      SizedBox(width: 8),
                      FuncButton(text: 'Cancel', onPressed: widget.onCancel),
                    ],
                  ),
                ])));
  }
}




 
