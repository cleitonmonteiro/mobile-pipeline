import 'package:demo_client/model/mobile.dart';
import 'package:demo_client/model/user.dart';
import 'package:flutter/foundation.dart';

class AppModel extends ChangeNotifier {
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  MobileModel? _selectedMobile;
  MobileModel? get selectedMobile => _selectedMobile;

  double _distanceToNotifier = 0.0;
  double get distanceToNotifier => _distanceToNotifier;

  void setUser(UserModel? user) {
    _currentUser = user;
    notifyListeners();
  }

  void setMobile(MobileModel? mobile) {
    _selectedMobile = mobile;
    // notifyListeners();
  }

  void setDistance(double distance) {
    _distanceToNotifier = distance;
    // notifyListeners();
  }
}
