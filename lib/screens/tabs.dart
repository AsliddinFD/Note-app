import 'package:flutter/material.dart';
import 'package:frontend/data/dummy_data.dart';
import 'package:frontend/screens/notes.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int activePageIndex = 0;

  void selectTab(int currentIndex) {
    setState(() {
      activePageIndex = currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = Notes(listNotes: notes);
    if (activePageIndex == 0) {
      activePage = Notes(listNotes: notes);
    } else if (activePageIndex == 1) {
      activePage = Notes(listNotes: likedNotes);
    }
    return Scaffold(
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        onTap: selectTab,
        currentIndex: activePageIndex,
        selectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.notes, color: Colors.white), label: 'Notes'),
          BottomNavigationBarItem(
              icon: Icon(Icons.star, color: Colors.white), label: 'Favorites')
        ],
      ),
    );
  }
}
