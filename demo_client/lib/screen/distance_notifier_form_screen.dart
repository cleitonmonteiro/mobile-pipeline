import 'package:demo_client/provider/app.dart';
import 'package:demo_client/screen/map_screen.dart';
import 'package:demo_client/service/api.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class DistanceNotifierFormScreen extends StatefulWidget {
  const DistanceNotifierFormScreen({Key? key}) : super(key: key);

  @override
  State<DistanceNotifierFormScreen> createState() =>
      _DistanceNotifierFormScreenState();
}

class _DistanceNotifierFormScreenState
    extends State<DistanceNotifierFormScreen> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  double distance = 0;

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  Future<Position?> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return null;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    return position;
  }

  handleConfirm() async {
    final currentPosition = await _getCurrentPosition();
    if (currentPosition != null) {
      final appProvider = Provider.of<AppModel>(context, listen: false);
      appProvider.setPosition(currentPosition);
      appProvider.setDistance(distance);

      const apiService = ApiService();

      final ok = await apiService.sendSubscription(appProvider.subscription);

      if (ok) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const MapScreen();
        }));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Cannot create the subscription.'),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Cannot get the current position.'),
      ));
    }
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
                  hintText: 'Distance (m)',
                  label: Text('Distance (m)'),
                ),
                onChanged: (value) {
                  distance = double.tryParse(value) ?? 0.0;
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
      ),
    );
  }
}
