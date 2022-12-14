import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
// import 'package:open_file/open_file.dart';

import 'package:intl/intl.dart';
import '../models/data_model.dart';
import './add_new_data.dart';
import './second_page_screen.dart';

class HomePageScreen extends StatefulWidget {
  static const String routePath = '/';
  final List<DataModel> data;
  final Function addNewData;
  const HomePageScreen(
      {super.key, required this.data, required this.addNewData});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  void _deleteData(String id) {
    widget.data.removeWhere((element) => element.id == id);
    setState(() {});
  }

  Future<void> createExel() async {
    final Workbook workBook = Workbook();
    final Worksheet sheet = workBook.worksheets[0];
    for (int i = 1; i <= widget.data.length; i++) {
      sheet.getRangeByName('A$i').setText(widget.data[i - 1].code);
      sheet.getRangeByName('B$i').setText(widget.data[i - 1].weight.toString());
      sheet.getRangeByName('C$i').setText(widget.data[i - 1].time.toString());
    }
    final List<int> bytes = workBook.saveAsStream();
    workBook.dispose();

    // const String path = '/storage/emulated/0/app';
    Directory? directoryVar = (await getExternalStorageDirectory());
    String path = directoryVar!.path;
    final String fileName =
        '$path/${DateFormat('H-m-s').format(DateTime.now())}.xlsx';
    print(fileName);
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    // OpenFile.open(fileName);
  }

  void modifyData(String id, String weight) {
    double weightNumber = double.parse(weight);
    for (int i = 0; i < widget.data.length; i++) {
      if (widget.data[i].id == id) {
        setState(() {
          widget.data[i].weight = weightNumber;
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
          addNewData: widget.addNewData,
          modifyData: modifyData,
          id: id,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Warehouse"),
        actions: [
          IconButton(
            onPressed: () => createExel(),
            icon: const Icon(Icons.download),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.data.length,
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
                      widget.data[index].code,
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
                      "${widget.data[index].weight} Kg",
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
                      DateFormat.yMd().format(widget.data[index].time),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () =>
                      _startAddNew(context, true, widget.data[index].id),
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () => _deleteData(widget.data[index].id),
                  icon: const Icon(Icons.delete),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SecondPageScreen(
                data: widget.data,
                addNewData: widget.addNewData,
              ),
            ),
          );
        },
      ),
    );
  }
}
