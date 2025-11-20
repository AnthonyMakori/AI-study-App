import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/user_model.dart';
import 'study.dart';
import 'quiz.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List modules = [];

  @override
  void initState() {
    super.initState();
    _loadModules();
  }

  Future<void> _loadModules() async {
    final data = await rootBundle.loadString('assets/sample_questions.json');
    final json = jsonDecode(data);
    setState(() {
      modules = json['modules'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text('Home', style: TextStyle(color: Colors.cyanAccent)),
        actions: [
          IconButton(onPressed: (){
            user.logout();
            Navigator.pushReplacementNamed(context, '/');
          }, icon: Icon(Icons.logout, color: Colors.white70))
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text('Welcome, ${user.email ?? 'Student'}', style: TextStyle(color: Colors.limeAccent, fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height:12),
          Text('Choose a module to start studying or take a quiz.', style: TextStyle(color: Colors.white70)),
          SizedBox(height:20),
          for (var m in modules) ModuleCard(module: m),
        ],
      ),
    );
  }
}

class ModuleCard extends StatelessWidget {
  final Map module;
  ModuleCard({required this.module});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white10,
      margin: EdgeInsets.symmetric(vertical:8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.all(12),
        title: Text(module['title'] ?? '', style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold)),
        subtitle: Text('${(module['questions'] as List).length} questions', style: TextStyle(color: Colors.white70)),
        trailing: PopupMenuButton(
          color: Colors.black,
          itemBuilder: (ctx) => [
            PopupMenuItem(value: 'study', child: Text('Study', style: TextStyle(color: Colors.cyanAccent))),
            PopupMenuItem(value: 'quiz', child: Text('Quiz', style: TextStyle(color: Colors.limeAccent))),
          ],
          onSelected: (v){
            if (v == 'study') Navigator.push(context, MaterialPageRoute(builder: (_) => StudyScreen(module: module)));
            else Navigator.push(context, MaterialPageRoute(builder: (_) => QuizScreen(module: module)));
          },
        ),
      ),
    );
  }
}
