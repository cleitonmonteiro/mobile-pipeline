import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_updates_demo/model/mobile.dart';
import 'package:mobile_updates_demo/utils/url.dart';

class ApiService {
  const ApiService();

  Future<MobileModel?> createMobile(String description) async {
    print('Description: $description');
    var response = await http.post(
      Uri.parse(Url.mobiles),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'description': description}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return MobileModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<List<MobileModel>?> sendUpdate() async {
    // TODO
  }
}
