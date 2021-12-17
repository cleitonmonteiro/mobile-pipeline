import 'package:demo_client/provider/app.dart';
import 'package:demo_client/screen/mobile_form_screen.dart';
import 'package:demo_client/service/api.dart';
import 'package:demo_client/screen/home_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? username;
  String? token;

  Future<bool> _login() async {
    token = await FirebaseMessaging.instance.getToken();
    print('Token: $token\nUsername: $username');
    const apiService = ApiService();

    if (username == null || token == null) {
      print('Username or token is null.');
      return false;
    }
    var user = await apiService.login(username!.toLowerCase(), token!);

    Provider.of<AppModel>(context, listen: false).setUser(user);
    return user != null;
  }

  handleConfirm() async {
    final ok = await _login();
    if (ok) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const MobileFormScreen();
      }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Cannot login.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Username',
                  label: Text('Username'),
                ),
                onChanged: (value) {
                  username = value.toLowerCase();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: handleConfirm,
        tooltip: 'Continue',
        child: const Icon(Icons.arrow_forward),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
