// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: TextButton(
                onPressed: () {
                  selectFile();
                },
                child: const Text('upload file')),
          ),
        ],
      ),
    );
  }
}

selectFile() async {
  FilePickerResult? file = await FilePicker.platform.pickFiles();
  if (file?.files.single.path == null) return;
  uploadFile(File(file!.files.single.path!));
}

uploadFile(File file) async {
  var multipartRequest = http.MultipartRequest('POST', Uri.parse('url'));
  var length = await file.length();
  var stream = http.ByteStream(file.openRead());
  var multipartFile =
      http.MultipartFile('name', stream, length, filename: basename(file.path));
  multipartRequest.files.add(multipartFile);
  var response = await multipartRequest.send();
  if (response.statusCode == 200) {
    // TODO
  }
}
