import 'package:flutter/material.dart';
import 'package:frontend/data/dummy_data.dart';
import 'package:frontend/models/Note.dart';
import 'package:frontend/screens/add_note.dart';
import 'package:frontend/screens/note_detail.dart';
import 'package:frontend/utils/styles.dart';
import 'package:frontend/widgets/note_card.dart';

class Notes extends StatefulWidget {
  const Notes({super.key, required this.listNotes});
  final List<Note> listNotes;
  @override
  State<Notes> createState() {
    return _NotesState();
  }
}

class _NotesState extends State<Notes> {
  void addNote(Note note) {
    setState(() {
      notes.add(note);
    });
  }

  void saveNote(int index, String newContent) {
    setState(() {
      notes[index].content = newContent;
    });
  }

  void deleteNote(Note note) {
    setState(() {
      notes.remove(note);
    });
  }

  void likeNote(Note note) {
    if (likedNotes.contains(note)) {
      likedNotes.remove(note);
    } else {
      likedNotes.add(note);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Notes'),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => AddNote(
                  addNote: addNote,
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: widget.listNotes.isEmpty
          ? const Center(
              child: Text('There are no notes here yet', style: customTextStyle,),
            )
          : ListView.builder(
              itemCount: widget.listNotes.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () async {
                  final updatedContent = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteDetail(
                        note: widget.listNotes[index],
                        saveNote: saveNote,
                        deleteNote: deleteNote,
                        likeNote: likeNote,
                      ),
                    ),
                  );

                  if (updatedContent != null) {
                    saveNote(index, updatedContent);
                  }
                },
                child: NoteCard(
                  content: widget.listNotes[index].content,
                ),
              ),
            ),
    );
  }
}
