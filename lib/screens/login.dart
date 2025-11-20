import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool loading = false;

  void _fakeLogin() async {
    setState(() => loading = true);
    await Future.delayed(Duration(seconds:1));
    Provider.of<UserModel>(context, listen:false).login('user123', _email.text);
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Icon(Icons.school, size: 96, color: Colors.cyanAccent),
                SizedBox(height: 16),
                Text('AI Study & Exam Prep', style: TextStyle(color: Colors.cyanAccent, fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 24),
                TextField(
                  controller: _email,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.white38),
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none)
                  ),
                ),
                SizedBox(height:12),
                TextField(
                  controller: _password,
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.white38),
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none)
                  ),
                ),
                SizedBox(height:16),
                ElevatedButton(
                  onPressed: loading ? null : _fakeLogin,
                  child: loading ? CircularProgressIndicator() : Text('Log in'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.limeAccent, foregroundColor: Colors.black),
                ),
                SizedBox(height:12),
                Text('Demo login — no backend required', style: TextStyle(color: Colors.white54)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
