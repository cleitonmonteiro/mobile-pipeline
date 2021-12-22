import 'dart:convert';

import 'package:demo_client/model/push_notification_data.dart';
import 'package:demo_client/provider/app.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

final LatLngBounds sydneyBounds = LatLngBounds(
  southwest: const LatLng(-34.022631, 150.620685),
  northeast: const LatLng(-33.571835, 151.325952),
);

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final FirebaseMessaging _messaging;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Map<CircleId, Circle> circles = <CircleId, Circle>{};

  LatLng? _markePosition;

  final bool _myLocationEnabled = true;
  late GoogleMapController _controller;

  void registerNotification() async {
    _messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print(
            'Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');

        try {
          PushNotificationData notification =
              PushNotificationData.fromJson(jsonDecode(message.data['json']));

          _markePosition =
              LatLng(notification.latitude, notification.longitude);
          markers.clear();
          circles.clear();
          _addMarkers();
          _addCircles();
          setState(() {});
        } catch (e) {
          print(e);
        }

        // if (_notificationInfo != null) {
        //   // For displaying the notification as an overlay
        //   showSimpleNotification(
        //     Text(_notificationInfo!.title!),
        //     leading: NotificationBadge(totalNotifications: _totalNotifications),
        //     subtitle: Text(_notificationInfo!.body!),
        //     background: Colors.cyan.shade700,
        //     duration: const Duration(seconds: 5),
        //   );
        // }
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  // checkForInitialMessage() async {
  //   RemoteMessage? initialMessage =
  //       await FirebaseMessaging.instance.getInitialMessage();

  //   if (initialMessage != null) {
  //     PushNotificationData notification = PushNotificationData(
  //       title: initialMessage.notification?.title,
  //       body: initialMessage.notification?.body,
  //       dataTitle: initialMessage.data['title'],
  //       dataBody: initialMessage.data['body'],
  //     );

  //     setState(() {
  //       _notificationInfo = notification;
  //       _totalNotifications++;
  //     });
  //   }
  // }

  _addMarkers() {
    const MarkerId markerId = MarkerId('mobile-marker');
    final mobileDescription = Provider.of<AppModel>(context, listen: false)
        .selectedMobile
        ?.description;

    final Marker marker = Marker(
      markerId: markerId,
      position: _markePosition!,
      infoWindow: InfoWindow(title: mobileDescription),
      onTap: () {},
    );
    markers[markerId] = marker;
  }

  _addCircles() {
    const String circleIdVal = 'circle-id';
    const CircleId circleId = CircleId(circleIdVal);
    final distanceToNotifier =
        Provider.of<AppModel>(context, listen: false).distanceToNotifier;

    final Circle circle = Circle(
      circleId: circleId,
      consumeTapEvents: true,
      strokeColor: Colors.red,
      strokeWidth: 2,
      center: _markePosition!,
      radius: distanceToNotifier,
      onTap: () {
        // _onCircleTapped(circleId);
      },
    );
    circles[circleId] = circle;
  }

  @override
  void initState() {
    registerNotification();
    // checkForInitialMessage();

    // TODO:
    //For handling notification when the app is in background
    // but not terminated
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   PushNotificationData notification = PushNotificationData(
    //     title: message.notification?.title,
    //     body: message.notification?.body,
    //     dataTitle: message.data['title'],
    //     dataBody: message.data['body'],
    //   );

    //   setState(() {
    //     _notificationInfo = notification;
    //     _totalNotifications++;
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final position = Provider.of<AppModel>(context, listen: false).position;
    final GoogleMap googleMap = GoogleMap(
      onMapCreated: onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(position!.latitude, position.longitude),
        zoom: 16,
      ),
      myLocationEnabled: _myLocationEnabled,
      // onCameraMove: _updateCameraPosition,
      markers: Set<Marker>.of(markers.values),
      circles: Set<Circle>.of(circles.values),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mobile on maps"),
      ),
      body: googleMap,
    );
  }

  // void _updateCameraPosition(CameraPosition position) {
  //   setState(() {
  //     _position = position;
  //   });
  // }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
      // _isMapCreated = true;
    });
  }
}
