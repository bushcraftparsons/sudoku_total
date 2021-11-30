import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

Future<String> get _localPath async {
  final directory = await getApplicationSupportDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/sudoku_state.json');
}

Future<File> writeState(Map<String, Object> state) async {
  final file = await _localFile;

  // Write the file
  String stateString = json.encode(state);
  return file.writeAsString('$stateString');
}

Future<Map<String, dynamic>> readState() async {
  print("Running read state");
  try {
    final file = await _localFile;

    // Read the file
    final stateString =  await file.readAsString();
    print("Got state " + stateString);
    return json.decode(stateString);
  } catch (e) {
    print("Encountered an error " + e.toString());
    // If encountering an error, return {}
    return {};
  }
}