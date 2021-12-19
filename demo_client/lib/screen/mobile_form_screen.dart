import 'package:demo_client/model/mobile.dart';
import 'package:demo_client/provider/app.dart';
import 'package:demo_client/screen/distance_notifier_form_screen.dart';
import 'package:demo_client/service/api.dart';
import 'package:demo_client/screen/home_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MobileFormScreen extends StatefulWidget {
  const MobileFormScreen({Key? key}) : super(key: key);

  @override
  State<MobileFormScreen> createState() => _MobileFormScreenState();
}

class _MobileFormScreenState extends State<MobileFormScreen> {
  List<MobileModel> mobiles = [];
  MobileModel? selectedMobile;
  bool loading = true;

  handleConfirm() async {
    Provider.of<AppModel>(context, listen: false).setMobile(selectedMobile);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const DistanceNotifierFormScreen();
    }));
  }

  fetchMobiles() async {
    const apiService = ApiService();
    loading = true;
    setState(() {});
    mobiles = await apiService.fetchMobiles() ?? [];
    selectedMobile = mobiles.first;
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    fetchMobiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select the mobile"),
      ),
      body: loading
          ? const CircularProgressIndicator(
              semanticsLabel: "Loading data",
            )
          : buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: selectedMobile != null ? handleConfirm : null,
        tooltip: 'Continue',
        child: const Icon(Icons.arrow_forward),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildContent() {
    if (mobiles.isEmpty) {
      return const Center(
        child: Text("No mobile found."),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        DropdownButton<MobileModel>(
            value: selectedMobile,
            onChanged: (MobileModel? newValue) {
              setState(() {
                selectedMobile = newValue!;
              });
            },
            items:
                mobiles.map<DropdownMenuItem<MobileModel>>((MobileModel value) {
              return DropdownMenuItem<MobileModel>(
                value: value,
                child: Text(value.description),
              );
            }).toList()),
      ]),
    );
  }
}
