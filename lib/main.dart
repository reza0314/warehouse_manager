import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './models/data_model.dart';

void main() {
  runApp(const MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<DataModel> _data = [
    DataModel(
      code: "1",
      time: DateTime.now(),
      weight: 12.3,
    ),
    DataModel(
      code: "2",
      time: DateTime.now(),
      weight: 14.0,
    ),
    DataModel(
      code: "3",
      time: DateTime.now(),
      weight: 18.0,
    ),
  ];

  void _deleteData(String id) {
    _data.removeWhere((element) => element.code == id);
    setState(() {});
  }

  void _startAddNew(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (context) {
        return GestureDetector(
          onTap: () {},
          child: ,
        );
      },
    );
  }
  // void addNewData(void){
  //   setState(() {

  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warehouse App',
      theme: ThemeData(
        textTheme: const TextTheme(
            bodyText1: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 20,
            ),
            bodyText2: TextStyle(
              fontFamily: 'RobotoCondensed',
              fontSize: 20,
            )),
      ),
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text("Warehouse"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.download),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: _data.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        "Code",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        _data[index].code,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "weight",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        "${_data[index].weight} Kg",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "date",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        DateFormat.yMd().format(_data[index].time),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () => _deleteData(_data[index].code),
                    icon: const Icon(Icons.delete),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
