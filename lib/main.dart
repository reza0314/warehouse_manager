// ignore_for_file: prefer_final_fields, unused_field

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import './models/data_model.dart';
import './screens/home_page_screen.dart';
import './screens/second_page_screen.dart';


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
      routes: <String, WidgetBuilder>{
        HomePageScreen.routePath: (context) => HomePageScreen(
              addNewData: addNewData,
              data: _data,
            ),
        SecondPageScreen.routePath: (context) => SecondPageScreen(
              data: _data,
              addNewData: addNewData,
            )
      },
    );
  }
}
