import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(NotesApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotesScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<String> notes = [];
  List<String> notestittle = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notes',
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 24),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: notes.length > 0
          ? Padding(
              padding: const EdgeInsets.all(4.0),
              child: MasonryGridView.builder(
                itemCount: notes.length,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black12),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notes[index],
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              notestittle[index],
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          : const SizedBox(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          openAlertBox();
          //_showAddNoteDialog(context);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  openAlertBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          String newNoteTitle = ''; // Initialize with an empty string
          String newNoteContent = '';
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                    child: Text(
                      "Add Note",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 24),
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 50,
                    child: Expanded(
                      flex: 2,
                      child: SizedBox(
                          height: 50,
                          child: TextField(
                            onChanged: (value) {
                              newNoteTitle = value;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: false,
                              contentPadding: const EdgeInsets.only(
                                  left: 10.0,
                                  top: 10.0,
                                  bottom: 10.0,
                                  right: 10.0),
                              hintText: ' Add Tittle',
                              hintStyle: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: Expanded(
                      flex: 2,
                      child: Container(
                          child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        onChanged: (value) {
                          newNoteContent = value;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: false,
                          contentPadding: const EdgeInsets.only(
                              left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
                          hintText: ' Add Notes',
                          hintStyle: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        String newNote = '$newNoteTitle';
                        notes.add(newNote);
                      });
                      setState(() {
                        String newNotetittle = '$newNoteContent';
                        notestittle.add(newNotetittle);
                      });
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: Text(
                        "Add",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
