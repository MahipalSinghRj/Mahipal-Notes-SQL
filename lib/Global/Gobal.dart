import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GlobalController extends GetxController{

  var box= GetStorage();

  String get titleName => box.read('titleName') ?? "";
  int get count => box.read('count') ?? 0;


  setTitleName({required String titleName}){
    box.write(titleName, titleName);
  }

  setCount({required int count}){
    box.write('count', count);
    debugPrint("Count value is : $count");
  }

}