// ignore_for_file: prefer_const_constructors, unused_field

import 'package:flutter/material.dart';

class NewDataPage extends StatefulWidget {
  final bool modify;
  final Function addNewData;
  final Function modifyData;
  final String id;
  const NewDataPage({
    super.key,
    required this.modify,
    required this.addNewData,
    required this.id,
    required this.modifyData,
  });

  @override
  State<NewDataPage> createState() => _NewDataState();
}

class _NewDataState extends State<NewDataPage> {
  final _weightTextFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      // child: const Text("hello world"),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            keyboardType: TextInputType.number,
            controller: _weightTextFieldController,
            decoration: const InputDecoration(helperText: "weight"),
          ),
          TextButton(
            onPressed: () {
              if (widget.modify) {
                widget.modifyData(
                  widget.id,
                  _weightTextFieldController.text,
                );
              } else {
                widget.addNewData(
                  _weightTextFieldController.text,
                );
              }
            },
            child: Text(widget.modify ? "modify" : "add"),
          )
        ],
      ),
    );
  }
}
