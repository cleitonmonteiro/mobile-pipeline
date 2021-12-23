import 'package:flutter/material.dart';
import 'package:mobile_updates_demo/screen/updates_screen.dart';

class MobileForm extends StatefulWidget {
  const MobileForm({Key? key}) : super(key: key);

  @override
  State<MobileForm> createState() => _MobileFormState();
}

class _MobileFormState extends State<MobileForm> {
  String? description;

  handleConfirm() async {
    final ok = true;
    if (ok) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return UpdatesScreen(description: description!);
      }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Cannot create a mobile.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a mobile example'),
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
                  hintText: 'Description',
                  label: Text('Mobile description'),
                ),
                onChanged: (value) {
                  description = value;
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
