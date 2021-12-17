import 'package:demo_client/screen/home_screen.dart';
import 'package:flutter/material.dart';

class DistanceNotifierFormScreen extends StatefulWidget {
  const DistanceNotifierFormScreen({Key? key}) : super(key: key);

  @override
  State<DistanceNotifierFormScreen> createState() =>
      _DistanceNotifierFormScreenState();
}

class _DistanceNotifierFormScreenState
    extends State<DistanceNotifierFormScreen> {
  double distance = 0;

  handleConfirm() async {
    // TODO: get the current position and send to server all the data
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return const HomePage();
    // }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter the distance to notifier"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Distance',
                  label: Text('Distance'),
                ),
                onChanged: (value) {
                  distance = double.parse(value);
                },
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
