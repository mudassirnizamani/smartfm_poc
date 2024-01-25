import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CreateEpisode extends StatefulWidget {
  const CreateEpisode({super.key});

  @override
  State<CreateEpisode> createState() => _CreateEpisodeState();
}

class _CreateEpisodeState extends State<CreateEpisode> {
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // File file = File(result.files.single.path!);
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        ElevatedButton.icon(
            onPressed: pickFile,
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 61, 186, 228))),
            icon: const Icon(Icons.insert_drive_file_sharp),
            label: const Text(
              'Pick File',
              style: TextStyle(fontSize: 25),
            )),
      ]),
    );
  }
}
