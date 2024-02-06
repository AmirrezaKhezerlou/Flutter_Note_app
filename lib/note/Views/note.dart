import 'package:get/get.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:notic/note/Controllers/note_controller.dart';
import '../../main_screen/Controllers/mainpage_controller.dart';

// ignore: must_be_immutable
class NotePage extends StatefulWidget {
  final String title;
  final String content;
  final int id;

  NotePage({required this.title, required this.content, required this.id});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  void setItems() {
    if (widget.id != -1) {
      controller.title_controller.text = widget.title;
      controller.content_controller.text = widget.content;
      setState(() {});
    }
  }

  NoteController controller = Get.put(NoteController());

  @override
  void initState() {
    setItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  NeumorphicButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: NeumorphicStyle(
                      color: Get.isDarkMode ? Color(0xff2f2f2f) : Colors.white,
                      surfaceIntensity: 0.25,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(10)),
                      depth: 2,
                      lightSource: LightSource.topLeft,
                    ),
                    child: Center(child: Icon(Icons.arrow_back_ios)),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Note',
                    style: Theme.of(context).textTheme.labelLarge,
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(
                child: Neumorphic(
                  style: NeumorphicStyle(
                    surfaceIntensity: 0.25,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                    depth: -7,
                    color: Get.isDarkMode ? Color(0xff2f2f2f) : Colors.white,
                    lightSource: LightSource.bottomRight,
                  ),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      TextFormField(
                        style: Theme.of(context).textTheme.labelLarge,
                        maxLines: 1,
                        maxLength: 20,
                        controller: controller.title_controller,
                        decoration: InputDecoration(
                            counter: SizedBox.shrink(),
                            contentPadding: EdgeInsets.all(10),
                            hintStyle: Theme.of(context).textTheme.labelLarge,
                            hintText: 'Title',
                            border: InputBorder.none),
                      ),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1000,
                        minLines: 1,
                        controller: controller.content_controller,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Write your notes here ...',
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
                            border: InputBorder.none),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NeumorphicButton(
            onPressed: () {
              if (controller.content_controller.text.isNotEmpty) {
                if (widget.id != -1) {
                  controller.updateNote(widget.id);
                } else {
                  DateTime dt = DateTime.now();
                  controller.addNote(
                    controller.content_controller.text,
                    dt.toString(),
                    controller.title_controller.text,
                  );
                }
              } else {
                Get.snackbar('Error', 'Cant Save Empty Message!');
              }
            },
            margin: EdgeInsets.only(bottom: 10),
            style: NeumorphicStyle(
              color: Get.isDarkMode ? Color(0xff2f2f2f) : Colors.white,
              surfaceIntensity: 0.02,
              boxShape: NeumorphicBoxShape.beveled(
                BorderRadius.circular(5),
              ),
              depth: 2,
              lightSource: LightSource.topLeft,
            ),
            child: Icon(Icons.done),
          ),
          NeumorphicButton(
            onPressed: () {
              if (widget.id != -1) {
                controller.deleteNote(widget.id);
                MainPageController MPcontroller = Get.put(MainPageController());
                MPcontroller.fetch_data().then((value) {
                  MPcontroller.notes.clear();
                  MPcontroller.notes.addAll(value);
                });
                Get.back();
              }
            },
            margin: EdgeInsets.only(bottom: 10),
            style: NeumorphicStyle(
              surfaceIntensity: 0.02,
              color: Get.isDarkMode ? Color(0xff2f2f2f) : Colors.white,
              boxShape: NeumorphicBoxShape.beveled(
                BorderRadius.circular(5),
              ),
              depth: 2,
              lightSource: LightSource.topLeft,
            ),
            child: Icon(Icons.delete),
          ),
          NeumorphicButton(
            onPressed: () {
              if (widget.id != -1) {
                controller.shareText(widget.content);
              }
            },
            margin: EdgeInsets.only(bottom: 10),
            style: NeumorphicStyle(
              color: Get.isDarkMode ? Color(0xff2f2f2f) : Colors.white,
              surfaceIntensity: 0.02,
              boxShape: NeumorphicBoxShape.beveled(
                BorderRadius.circular(5),
              ),
              depth: 2,
              lightSource: LightSource.topLeft,
            ),
            child: Icon(Icons.share),
          ),
        ],
      ),
    );
  }
}
