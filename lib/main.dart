// ignore_for_file: prefer_final_fields, unused_field

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './models/data_model.dart';
import './widgets/add_new_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(MyApp(
    cam: firstCamera,
  ));
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  final CameraDescription cam;
  const MyApp({super.key, required this.cam});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late CameraController _camController =
      CameraController(widget.cam, ResolutionPreset.medium, enableAudio: false);

  late Future<void> _initializeControllerFuture = _camController.initialize();

  final List<DataModel> _data = [
    DataModel(
      code: "1",
      time: DateTime.now(),
      weight: 12.3,
      id: "${1}${DateTime.now()}${12.3}",
    ),
    DataModel(
      code: "2",
      time: DateTime.now(),
      weight: 14.0,
      id: "${2}${DateTime.now()}${14.0}",
    ),
    DataModel(
      code: "3",
      time: DateTime.now(),
      id: "${3}${DateTime.now()}${18.0}",
      weight: 18.0,
    ),
  ];

  void _deleteData(String id) {
    _data.removeWhere((element) => element.id == id);
    setState(() {});
  }

  void addNewData(String weight) {
    // ignore: unnecessary_null_comparison
    if (widget == null) return;

    double weightNumber = double.parse(weight);
    DataModel newData = DataModel(
      code: "${_data.length + 1}",
      time: DateTime.now(),
      weight: weightNumber,
      id: "${_data.length + 1}${DateTime.now()}$weightNumber",
    );
    setState(() {
      _data.add(newData);
    });
  }

  void modifyData(String id, String weight) {
    double weightNumber = double.parse(weight);
    for (int i = 0; i < _data.length; i++) {
      if (_data[i].id == id) {
        setState(() {
          _data[i].weight = weightNumber;
        });
        break;
      }
    }
  }

  void _startAddNew(BuildContext ctx, bool modify, String id) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewDataPage(
          modify: modify,
          addNewData: addNewData,
          modifyData: modifyData,
          id: id,
        );
      },
    );
  }
  // void addNewData(void){
  //   setState(() {

  //   });
  // }

  @override
  void dispose() {
    _camController.dispose();
    super.dispose();
  }

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
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Warehouse"),
          actions: [
            IconButton(
              onPressed: () => _startAddNew(context, false, "1"),
              icon: const Icon(Icons.add),
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
                  Text("${index + 1}"),
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
                    onPressed: () =>
                        _startAddNew(context, true, _data[index].id),
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () => _deleteData(_data[index].id),
                    icon: const Icon(Icons.delete),
                  )
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _startAddNew(context, false, "1"),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
