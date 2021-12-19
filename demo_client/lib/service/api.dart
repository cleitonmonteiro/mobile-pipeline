import 'dart:convert';

import 'package:demo_client/model/mobile.dart';
import 'package:demo_client/model/subscription.dart';
import 'package:demo_client/model/user.dart';
import 'package:demo_client/utils/url.dart';
import 'package:http/http.dart' as http;

class ApiService {
  const ApiService();

  Future<UserModel?> login(String username, String token) async {
    print('Token: $token\nUsername: $username');
    var response = await http.post(
      Uri.parse(Url.login),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'username': username, 'token': token}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<List<MobileModel>?> fetchMobiles() async {
    var response = await http.get(Uri.parse(Url.mobiles));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<MobileModel>.from(
          l.map((model) => MobileModel.fromJson(model)));
    }
    return null;
  }

  Future<bool> sendSubscription(SubscriptionModel subscriptionModel) async {
    var response = await http.post(
      Uri.parse(Url.newSubscription),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(subscriptionModel.toJson()),
    );

    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }
}
