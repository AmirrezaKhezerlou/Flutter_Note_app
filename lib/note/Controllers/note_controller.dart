import 'package:get/get.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:notic/main_screen/Controllers/mainpage_controller.dart';
import 'package:notic/sqflite_helper.dart';
import 'package:flutter_share/flutter_share.dart';


class NoteController extends GetxController {
  DatabaseHelper dbHelper = DatabaseHelper();
  TextEditingController title_controller = TextEditingController();
  TextEditingController content_controller = TextEditingController();

  Future<void> addNote(String content, String date, String title) async {
    await dbHelper.insertData(content, date, title);
    MainPageController MPcontroller = Get.put(MainPageController());
    MPcontroller.fetch_data().then((value) {
      MPcontroller.notes.clear();
      MPcontroller.notes.addAll(value);
    });
    Get.back();
  }

  Future<void>deleteNote(int id)async{
    await dbHelper.deleteNoteByID(id);
    MainPageController MPcontroller = Get.put(MainPageController());
    MPcontroller.fetch_data().then((value) {
      MPcontroller.notes.clear();
      MPcontroller.notes.addAll(value);
    });
    Get.back();
  }


  Future<void>updateNote(int id)async{
    DateTime dt = DateTime.now();
    await dbHelper.updateNote(id, title_controller.text, content_controller.text, dt.toString());
    MainPageController MPcontroller = Get.put(MainPageController());
    MPcontroller.fetch_data().then((value) {
      MPcontroller.notes.clear();
      MPcontroller.notes.addAll(value);
    });
    Get.back();
  }

  Future<void> shareText(String text)async{
    Get.snackbar('PENDING', 'Pending your share request...');
    await FlutterShare.share(title: 'Shared note',text: text);
  }






}
