import 'package:flutter/material.dart';

class AddPathElement extends StatefulWidget {
  final String labelText;

  AddPathElement({required this.labelText});

  @override
  _AddPathElementState createState() => _AddPathElementState();
}

class _AddPathElementState extends State<AddPathElement> {
  TextEditingController _textController = TextEditingController();

  void callTest(String test) async{

  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.labelText),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _textController,
            decoration: InputDecoration(labelText: widget.labelText),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(_textController.text);
                },
                child: Text('Enregistrer'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog without saving
                },
                child: Text('Annuler'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
