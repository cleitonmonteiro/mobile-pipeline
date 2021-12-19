import 'package:demo_client/model/mobile.dart';
import 'package:demo_client/model/subscription.dart';
import 'package:demo_client/model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class AppModel extends ChangeNotifier {
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  MobileModel? _selectedMobile;
  MobileModel? get selectedMobile => _selectedMobile;

  double _distanceToNotifier = 0.0;
  double get distanceToNotifier => _distanceToNotifier;

  Position? _position;
  Position? get position => _position;

  SubscriptionModel get subscription => SubscriptionModel(
      false,
      _currentUser!.id,
      _selectedMobile!.id,
      _position!.latitude,
      position!.longitude,
      distanceToNotifier);

  void setUser(UserModel? user) {
    _currentUser = user;
    notifyListeners();
  }

  void setMobile(MobileModel? mobile) {
    _selectedMobile = mobile;
    notifyListeners();
  }

  void setDistance(double distance) {
    _distanceToNotifier = distance;
    notifyListeners();
  }

  void setPosition(Position position) {
    _position = position;
    notifyListeners();
  }
}
