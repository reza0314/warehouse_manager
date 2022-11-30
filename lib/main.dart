import 'package:flutter/material.dart';

import './models/data_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List<DataModel> data = [
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

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warehouse App',
      theme: ThemeData(textTheme: TextTheme(bodyText1: TextStyle(),),),
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
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text("Code"),
                      Text(data[index].code),
                    ],
                  ),
                  Column(
                    children: [
                      const Text("weight"),
                      Text(
                        "${data[index].weight} Kg",
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text("date"),
                      Text(data[index].code),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {},
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
