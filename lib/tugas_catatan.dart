// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Note {
  String title;
  String content;
  Note({required this.title, required this.content});
}

class NotesModel extends ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get notes => List.unmodifiable(_notes);

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void removeNote(int index) {
    _notes.removeAt(index);
    notifyListeners();
  }
}

class TugasCatatanPage extends StatelessWidget {
  const TugasCatatanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotesModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Catatan'),
          backgroundColor: Colors.teal,
        ),
        body: const NotesScreen(),
      ),
    );
  }
}

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotesModel>(
      builder:
          (context, model, _) => Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: model.notes.length,
                  itemBuilder: (context, index) {
                    final note = model.notes[index];
                    return ListTile(
                      title: Text(note.title),
                      subtitle: Text(note.content),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => model.removeNote(index),
                      ),
                      onTap: () async {
                        // Edit note
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) =>
                                    AddEditNoteScreen(note: note, isEdit: true),
                          ),
                        );
                        if (result != null && result is Note) {
                          model.notes[index].title = result.title;
                          model.notes[index].content = result.content;
                          model.notifyListeners();
                        }
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AddEditNoteScreen(),
                      ),
                    );
                    if (result != null && result is Note) {
                      Provider.of<NotesModel>(
                        context,
                        listen: false,
                      ).addNote(result);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text('Tambah Catatan'),
                ),
              ),
            ],
          ),
    );
  }
}

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;
  final bool isEdit;
  const AddEditNoteScreen({this.note, this.isEdit = false, super.key});

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen>
    with WidgetsBindingObserver {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(
      text: widget.note?.content ?? '',
    );
    print('AddEditNoteScreen initState');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _titleController.dispose();
    _contentController.dispose();
    print('AddEditNoteScreen dispose');
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Simpan draf sementara (bisa pakai shared_preferences untuk persistensi)
      print('App paused, simpan draf sementara');
    }
  }

  void _save() {
    if (_titleController.text.trim().isEmpty) return;
    Navigator.pop(
      context,
      Note(title: _titleController.text, content: _contentController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Catatan' : 'Tambah Catatan'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Judul"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: "Isi Catatan"),
              maxLines: 4,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
