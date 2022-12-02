// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../models/data_model.dart';

class SecondPageScreen extends StatefulWidget {
  static const routePath = '/2ndPage';
  final List<DataModel> data;
  final Function addNewData;
  const SecondPageScreen(
      {super.key, required this.data, required this.addNewData});

  @override
  State<SecondPageScreen> createState() => _SecondPageScreenState();
}

class _SecondPageScreenState extends State<SecondPageScreen> {
  final TextEditingController _weightTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("add new data"),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _weightTextController,
              decoration: const InputDecoration(
                hintText: "wight",
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            TextButton(
              onPressed: () => widget.addNewData(_weightTextController.text),
              child: const Text("Add"),
            )
          ],
        ),
      ),
    );
  }
}
