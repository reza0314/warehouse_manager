// ignore_for_file: prefer_const_constructors, unused_field, must_be_immutable, slash_for_doc_comments

import 'package:flutter/material.dart';

class NewDataPage extends StatefulWidget {
  final bool modify;
  final Function addNewData;
  final Function modifyData;
  final String id;

  NewDataPage({
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
  TextEditingController _weightTextFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Typing(
      weightTextFieldController: _weightTextFieldController,
      widget: widget,
    );
  }
}

/*********************************************************************************************/
class Typing extends StatefulWidget {
  const Typing({
    Key? key,
    required TextEditingController weightTextFieldController,
    required this.widget,
  })  : _weightTextFieldController = weightTextFieldController,
        super(key: key);

  final TextEditingController _weightTextFieldController;
  final NewDataPage widget;

  @override
  State<Typing> createState() => _TypingState();
}

class _TypingState extends State<Typing> {
  @override
  Widget build(BuildContext context) {
    return Card(
      // child: const Text("hello world"),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            keyboardType: TextInputType.number,
            controller: widget._weightTextFieldController,
            decoration: const InputDecoration(helperText: "weight"),
          ),
          IconButton(
            onPressed: () {
              setState(() {
              });
            },
            icon: Icon(
              Icons.camera_alt_rounded,
            ),
          ),
          TextButton(
            onPressed: () {
              if (widget.widget.modify) {
                widget.widget.modifyData(
                  widget.widget.id,
                  widget._weightTextFieldController.text,
                );
              } else {
                widget.widget.addNewData(
                  widget._weightTextFieldController.text,
                );
              }
            },
            child: Text(widget.widget.modify ? "modify" : "add"),
          ),
        ],
      ),
    );
  }
}
