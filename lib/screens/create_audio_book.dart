import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smartfm_poc/config/routes.dart';
import 'package:smartfm_poc/services/books_service.dart';

class CreateAudioBook extends StatefulWidget {
  const CreateAudioBook({super.key});

  @override
  State<CreateAudioBook> createState() => _CreateAudioBookState();
}

class _CreateAudioBookState extends State<CreateAudioBook> {
  String title = '';
  String genre = '';
  String description = '';
  String language = '';
  String author = '';
  File? cover;

  Future<void> createAudioBook() async {
    if (title.isEmpty ||
        genre.isEmpty ||
        description.isEmpty ||
        cover == null) {
      Fluttertoast.showToast(
          msg: "Cover, Name, Genre, Author, Description and Cover are required",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    try {
      final navigator = Navigator.of(context);

      await BooksService.createBook(
          title, description, genre, cover!, language, author);

      Fluttertoast.showToast(
          msg: "Successfully Created Audiobook",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green[800],
          textColor: Colors.white,
          fontSize: 16.0);

      navigator.pushNamed(Routes.home);
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Audio Book'),
          centerTitle: true,
          backgroundColor: const Color(0xff2c3136),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 25,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Name',
                    ),
                    onChanged: (value) => setState(() {
                      title = value;
                    }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Choose a unique name",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Author',
                    ),
                    onChanged: (value) => setState(() {
                      author = value;
                    }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Description',
                    ),
                    onChanged: (value) => setState(() {
                      description = value;
                    }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Choose a unique description",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Genre',
                    ),
                    onChanged: (value) => setState(() {
                      genre = value;
                    }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Choose a unique Genre",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Language',
                    ),
                    onChanged: (value) => setState(() => language = value),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: pickFile,
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(250, 50)),
                    child: const Text("Cover"),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: createAudioBook,
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(450, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
