import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notic/sqflite_helper.dart';

class MainPageController extends GetxController {
  RxList<Map<String, dynamic>> notes = <Map<String, dynamic>>[].obs;
  DatabaseHelper dbHelper = DatabaseHelper();
  TextEditingController searchController = TextEditingController();

  Future<List<Map<String, dynamic>>> fetch_data() async {
    List<Map<String, dynamic>> data = await dbHelper.getDataByDate();
    return data;
  }

  @override
  void onInit() {
    fetch_data().then((value) {
      notes.clear();
      notes.addAll(value);
    });
    super.onInit();
  }

  void search_data(String text) async {
    if (text.isNotEmpty) {
      List<Map<String, dynamic>> data = await dbHelper.searchNotes(text);
      notes.clear();
      notes.addAll(data);
    } else {
      fetch_data().then((value) {
        notes.clear();
        notes.addAll(value);
      });
    }
  }

  void showDialog() {
    Get.dialog(AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Developed With ❤ By AMIRREZA Khezerlou',
                  textDirection: TextDirection.ltr,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                'IMPORTANT! , all your notes will be destroyed when you uninstall app. please take backup first.',
                textDirection: TextDirection.ltr,
              )),
            ],
          )
        ],
      ),
    ));
  }
}
