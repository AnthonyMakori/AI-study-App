import 'package:flutter/material.dart';
import '../services/openai_service.dart';
import 'package:provider/provider.dart';

class StudyScreen extends StatefulWidget {
  final Map module;
  StudyScreen({required this.module});

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  String prompt = '';
  String aiResponse = '';
  bool loading = false;

  void askAI() async {
    if (prompt.trim().isEmpty) return;
    setState(() => loading = true);
    final svc = Provider.of<OpenAIService>(context, listen:false);
    try {
      final r = await svc.explainConcept(prompt);
      setState(() {
        aiResponse = r;
      });
    } catch (e) {
      setState(() {
        aiResponse = 'Failed to get explanation. Make sure you set OPENAI_API_KEY in the service.';
      });
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study: ${widget.module['title']}', style: TextStyle(color: Colors.cyanAccent)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Ask the AI to explain a concept:', style: TextStyle(color: Colors.white70)),
            SizedBox(height:8),
            TextField(
              minLines: 1,
              maxLines: 4,
              onChanged: (v)=>prompt = v,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'e.g., Explain simultaneous equations in simple steps',
                hintStyle: TextStyle(color: Colors.white38),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none)
              ),
            ),
            SizedBox(height:12),
            ElevatedButton(
              onPressed: loading ? null : askAI,
              child: loading ? CircularProgressIndicator() : Text('Explain', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyanAccent),
            ),
            SizedBox(height:12),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(8)),
                  child: Text(aiResponse.isEmpty ? 'AI explanation will appear here.' : aiResponse,
                    style: TextStyle(color: Colors.white70)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
