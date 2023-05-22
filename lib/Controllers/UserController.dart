import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Debug/printme.dart';

class UserDetailsController extends GetxController {
  Future<dynamic> getUserData() async {
    try {
      var client = http.Client();
      var url = "http://192.168.74.239:8080/products/1";
      var uri = Uri.parse(url);
      var response = await client.get(uri);
      printError1("Response log is :");
      log(response.body);
      if (response.statusCode == 200) {
        //var data = findCsrModelFromJson(response.body);
        //return data;
      } else {
        return null;
      }
    } catch (e) {
      printError1(e.toString());
      return null;
    }
  }
}
