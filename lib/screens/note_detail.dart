import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/data/dummy_data.dart';
import 'package:frontend/models/Note.dart';
import 'package:frontend/utils/styles.dart';

class NoteDetail extends StatefulWidget {
  const NoteDetail({
    super.key,
    required this.note,
    required this.saveNote,
    required this.deleteNote,
    required this.likeNote,
  });
  final void Function(int index, String newContent) saveNote;
  final void Function(Note note) deleteNote;
  final void Function(Note note) likeNote;

  final Note note;
  @override
  State<NoteDetail> createState() {
    return _NoteDetailState();
  }
}

class _NoteDetailState extends State<NoteDetail> {
  final textController = TextEditingController();
  bool isLiked = false;
  @override
  void initState() {
    super.initState();
    textController.text = widget.note.content;
    isLiked = likedNotes.contains(widget.note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, textController.text);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          widget.note.content,
          overflow: TextOverflow.ellipsis,
          style: customHeaderTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {
              widget.likeNote(widget.note);
              setState(() {
                isLiked = !isLiked;
              });
            },
            icon: isLiked
                ? const Icon(Icons.star, color: Colors.white)
                : const Icon(Icons.star_border, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              widget.deleteNote(widget.note);
              Navigator.pop(context);
            },
            icon: const Icon(CupertinoIcons.trash, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          maxLines: null,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          style: customTextStyle,
          controller: textController,
          onEditingComplete: () {
            widget.saveNote(
              notes.indexOf(widget.note),
              textController.text.trim().isEmpty
                  ? widget.note.content
                  : textController.text,
            );
          },
        ),
      ),
    );
  }
}