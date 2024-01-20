import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smartfm_poc/config/routes.dart';
import 'package:smartfm_poc/services/audio_books.dart';

class CreateAudioBook extends StatefulWidget {
  const CreateAudioBook({super.key});

  @override
  State<CreateAudioBook> createState() => _CreateAudioBookState();
}

class _CreateAudioBookState extends State<CreateAudioBook> {
  String name = '';
  String genre = '';
  String description = '';
  File? cover;

  Future<void> createAudioBook() async {
    if (name.isEmpty || genre.isEmpty || description.isEmpty || cover == null) {
      Fluttertoast.showToast(
          msg: "Cover, Name, Genre and Description are required",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    try {
      await AudioBookService()
          .createAudioBook(name, description, genre, cover!);

      Fluttertoast.showToast(
          msg: "Successfully Created Audiobook",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green[800],
          textColor: Colors.white,
          fontSize: 16.0);

      Navigator.pushNamed(context, Routes.home);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      cover = File(result.files.single.path!);
    } else {
      Fluttertoast.showToast(
          msg: "Name, Genre and Description are required",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
                onChanged: (value) => setState(() {
                  name = value;
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
                onChanged: (value) => setState(() {
                  description = value;
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Genre',
                ),
                onChanged: (value) => setState(() {
                  genre = value;
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: pickFile,
                style: ElevatedButton.styleFrom(fixedSize: const Size(250, 50)),
                child: const Text("Cover"),
              ),
              ElevatedButton(
                onPressed: createAudioBook,
                style: ElevatedButton.styleFrom(fixedSize: const Size(250, 50)),
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
