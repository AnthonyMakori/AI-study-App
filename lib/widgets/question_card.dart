import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  final List options;
  final void Function(String) onSelect;

  QuestionCard({required this.question, required this.options, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white10,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question, style: TextStyle(color: Colors.limeAccent, fontWeight: FontWeight.bold)),
            SizedBox(height:8),
            for (var o in options) ElevatedButton(
              onPressed: ()=>onSelect(o),
              child: Align(alignment: Alignment.centerLeft, child: Text(o, style: TextStyle(color: Colors.black))),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
            )
          ],
        ),
      ),
    );
  }
}
