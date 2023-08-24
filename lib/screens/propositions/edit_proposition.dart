import 'package:flutter/material.dart';
import '../../models/proposition.dart'; // Import your Proposition class

class EditPropositionPage extends StatefulWidget {
  final Proposition proposition;

  EditPropositionPage({required this.proposition});

  @override
  _EditPropositionPageState createState() => _EditPropositionPageState();
}

class _EditPropositionPageState extends State<EditPropositionPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.proposition.title ?? '';
    _contentController.text = widget.proposition.content ?? '';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    // Save changes to your Firestore or backend here
    // Update the proposition object if needed

    Navigator.pop(context); // Navigate back to the previous page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Proposition'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _contentController,
              maxLines: null,
              decoration: InputDecoration(labelText: 'Content'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveChanges,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
