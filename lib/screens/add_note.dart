import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:frontend/models/Note.dart';
import 'package:frontend/utils/styles.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key, required this.addNote});
  final void Function(Note note) addNote;

  @override
  State<AddNote> createState() {
    return _AddNoteState();
  }
}

class _AddNoteState extends State<AddNote> {
  final textController = TextEditingController();
  void addNote() {
    if (textController.text.trim().isEmpty) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          content: const Text('Please fill the text field'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
    } else {
      widget.addNote(Note(content: textController.text));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          border: Border.symmetric(
              horizontal: BorderSide(color: Colors.white),
              vertical: BorderSide.none),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: textController,
                style: customTextStyle,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: 'Type here',
                    hintStyle: customTextStyle),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: customTextStyle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: addNote,
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 45),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17)),
                        backgroundColor:
                            const Color.fromARGB(255, 122, 122, 122)),
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
