import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smartfm_poc/config/config.dart';
import 'package:smartfm_poc/config/routes.dart';
import 'package:smartfm_poc/models/audio_book.dart';
import 'package:smartfm_poc/services/audio_books.dart';

class CreateChapter extends StatefulWidget {
  const CreateChapter({super.key});

  @override
  State<CreateChapter> createState() => _CreateChapterState();
}

class _CreateChapterState extends State<CreateChapter> {
  String title = '';
  String? selectedBookId;
  File? chapter;

  void updateSelectedBookId(String id) {
    setState(() {
      selectedBookId = id;
    });
  }

  Future<void> pickChapterFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowedExtensions: ["mp3", "flac"], type: FileType.custom);

    if (result != null) {
      chapter = File(result.files.single.path!);
    } else {
      Fluttertoast.showToast(
        msg: "Pick a chapter file",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> createChapter() async {
    final navigator = Navigator.of(context);
    print("ID $title");
    if (title.isEmpty ||
        selectedBookId == null ||
        selectedBookId!.isEmpty ||
        chapter == null) {
      Fluttertoast.showToast(
        msg: "Fill the details correctly",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    try {
      await AudioBookService.createChapter(title, selectedBookId!, chapter!);

      navigator.pushNamed(Routes.studio);
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
        msg: "Something went wrong",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Chapter'),
        centerTitle: true,
        backgroundColor: const Color(0xff2c3136),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              TextField(
                onChanged: (value) => setState(() => title = value),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Title",
                ),
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
              ElevatedButton(
                onPressed: pickChapterFile,
                style: ElevatedButton.styleFrom(fixedSize: const Size(250, 50)),
                child: const Text("Pick Chapter"),
              ),
              const SizedBox(
                height: 20,
              ),
              PickBook(
                updateSelectedBookId: updateSelectedBookId,
                selectedId: selectedBookId,
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: createChapter,
                style: ElevatedButton.styleFrom(fixedSize: const Size(350, 50)),
                child: const Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PickBook extends StatefulWidget {
  final String? selectedId;
  final Function(String id) updateSelectedBookId;

  const PickBook(
      {required this.updateSelectedBookId,
      required this.selectedId,
      super.key});

  @override
  State<PickBook> createState() => _PickBookState();
}

class _PickBookState extends State<PickBook> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AudioBook>>(
        future: AudioBookService.fetchAudioBooks(),
        builder:
            (BuildContext context, AsyncSnapshot<List<AudioBook>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("loading...");
          } else if (snapshot.connectionState == ConnectionState.done) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => widget.updateSelectedBookId(
                        snapshot.data![index].audioBookId),
                    child: ListTile(
                      title: Row(
                        children: [
                          SizedBox(
                            width: 50,
                            height: 60,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                "${Config.apiBaseUrl}/${snapshot.data?[index].coverImage}",
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                          Text(snapshot.data?[index].name ?? "")
                        ],
                      ),
                      leading: Radio<String>(
                        value: snapshot.data?[index].audioBookId ?? "",
                        groupValue: widget.selectedId,
                        onChanged: (String? value) =>
                            widget.updateSelectedBookId(value ?? ""),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Text("waiting...");
          }
        });
  }
}
