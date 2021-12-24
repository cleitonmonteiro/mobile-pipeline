import 'package:flutter/material.dart';
import 'package:mobile_updates_demo/screen/updates_screen.dart';
import 'package:mobile_updates_demo/service/api.dart';

class MobileForm extends StatefulWidget {
  const MobileForm({Key? key}) : super(key: key);

  @override
  State<MobileForm> createState() => _MobileFormState();
}

class _MobileFormState extends State<MobileForm> {
  final apiService = const ApiService();
  String? description;

  _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  handleConfirm() async {
    if (description != null) {
      final mobile = await apiService.createMobile(description!);

      if (mobile != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return UpdatesScreen(mobile: mobile);
        }));
      } else {
        _showMessage('Description cannot be empty');
      }
    } else {
      _showMessage('Description cannot be empty');
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
