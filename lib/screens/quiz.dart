import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  final Map module;
  QuizScreen({required this.module});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int index = 0;
  int score = 0;

  void answer(String selected) {
    final q = widget.module['questions'][index];
    if (selected == q['answer']) score++;
    setState(() {
      index++;
      if (index >= (widget.module['questions'] as List).length) {
        // show result
        showDialog(context: context, builder: (_) => AlertDialog(
          backgroundColor: Colors.black,
          title: Text('Quiz complete', style: TextStyle(color: Colors.cyanAccent)),
          content: Text('Score: \$score', style: TextStyle(color: Colors.white70)),
          actions: [TextButton(onPressed: (){ Navigator.pop(context); Navigator.pop(context); }, child: Text('OK'))],
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final questions = widget.module['questions'] as List;
    if (questions.isEmpty) return Scaffold(body: Center(child: Text('No questions', style: TextStyle(color: Colors.white70))));
    if (index >= questions.length) return Scaffold(body: Center(child: Text('Done', style: TextStyle(color: Colors.white70))));
    final q = questions[index];
    return Scaffold(
      appBar: AppBar(title: Text('Quiz: ${widget.module['title']}', style: TextStyle(color: Colors.cyanAccent)), backgroundColor: Colors.black),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Question ${index+1}/${questions.length}', style: TextStyle(color: Colors.white70)),
            SizedBox(height:12),
            Text(q['question'], style: TextStyle(color: Colors.limeAccent, fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height:16),
            for (var opt in q['options']) ElevatedButton(
              onPressed: ()=>answer(opt),
              child: Align(alignment: Alignment.centerLeft, child: Text(opt, style: TextStyle(color: Colors.black))),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent, foregroundColor: Colors.black),
            ),
            Spacer(),
            Text('Score: \$score', style: TextStyle(color: Colors.amberAccent)),
          ],
        ),
      ),
    );
  }
}
