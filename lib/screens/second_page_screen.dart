// ignore_for_file: prefer_const_literals_to_create_immutables, constant_identifier_names, depend_on_referenced_packages

import 'dart:io';
import 'package:image/image.dart' as img;

import 'package:flutter/material.dart';
import '../models/data_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';

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
  img.Image? _image;
  String _path = '';
  String _ocrText = "";
  // static const img_url =
  //     "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpngimages.in%2Fwelcome%2Fshow%2Floding-picture-png&psig=AOvVaw0qytbV6fGI4s1L7Ls9406W&ust=1670143628793000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCOCIpoCI3fsCFQAAAAAdAAAAABAE";
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () async {
                    final xFileImage = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (xFileImage == null) return;
                    _path = xFileImage.path;
                    final bytes = await File(_path).readAsBytes();
                    _image = img.decodeImage(bytes);
                    _ocrText = await FlutterTesseractOcr.extractText(_path);
                    print(_ocrText);
                    // double? ansDouble = double.tryParse(_ocrText);
                    // print(ansDouble);
                    double ans = 12.3;
                    _weightTextController.text = ans.toString();

                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.camera_alt_rounded,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (_weightTextController.text == "") return;
                    widget.addNewData(_weightTextController.text);
                    _weightTextController.text = "";
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
            // _image == null
            //     ? Container()
            //     : FittedBox(
            //         fit: BoxFit.cover,
            //         child: SizedBox(
            //           height: MediaQuery.of(context).size.width,
            //           child: Image.file(
            //             File(
            //               _path,
            //             ),
            //           ),
            //         ),
            //       ),
          ],
        ),
      ),
    );
  }
}
