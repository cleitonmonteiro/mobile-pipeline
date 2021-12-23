import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class UpdatesScreen extends StatefulWidget {
  const UpdatesScreen({Key? key, required this.description}) : super(key: key);

  final String description;

  @override
  State<UpdatesScreen> createState() => _UpdatesScreenState();
}

class _UpdatesScreenState extends State<UpdatesScreen> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  Position? _lastPosition;
  int _updateCount = 0;

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

  handlePositionUpdate(Position position) {
    print("Location update: ${position.latitude} : ${position.longitude}");
    setState(() {
      _lastPosition = position;
      _updateCount++;
    });
  }

  Future<Position?> _startingPositionUpdates() async {
    final hasPermission = await _handlePermission();
    if (!hasPermission) {
      return null;
    }

    Geolocator.getPositionStream().listen(handlePositionUpdate);
  }

  @override
  void initState() {
    _startingPositionUpdates();
    super.initState();
  }

  List<Widget> buildPosition() {
    if (_lastPosition != null) {
      return [
        Text(
          'Lat: ${_lastPosition!.latitude.toStringAsFixed(8)}',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Text(
          'Lng: ${_lastPosition!.longitude.toStringAsFixed(8)}',
          style: Theme.of(context).textTheme.subtitle1,
        )
      ];
    }
    return [
      Text(
        'Unknown',
        style: Theme.of(context).textTheme.subtitle1,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.description),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Last position',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              'Update count ($_updateCount)',
              style: Theme.of(context).textTheme.caption,
            ),
            const SizedBox(height: 10),
            ...buildPosition(),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
