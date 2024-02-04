import 'package:get/get.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:notic/main_screen/Controllers/mainpage_controller.dart';
import 'package:notic/note/Views/note.dart';

// ignore: must_be_immutable
class MainPage extends StatelessWidget {
  MainPageController controller = Get.put(MainPageController());

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
                      controller.showDialog();
                    },
                    style: NeumorphicStyle(
                        surfaceIntensity: 0.25,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(10)),
                        depth: 5,
                        lightSource: LightSource.topLeft,
                        color: Colors.white),
                    child: Center(child: Icon(Icons.menu)),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'All Notes',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2f2f2f)),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    'Explore all notes you wrote.',
                    style: TextStyle(fontSize: 10, color: Color(0xff707070)),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: Neumorphic(
                        style: NeumorphicStyle(
                            surfaceIntensity: 0.25,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(10)),
                            depth: 5,
                            lightSource: LightSource.topLeft,
                            color: Colors.white),
                        child: TextFormField(
                          onChanged: (v) {
                            controller.search_data(v);
                          },
                          controller: controller.searchController,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Color(0xff707070)),
                            hintText: 'Search your notes',
                            contentPadding:
                                EdgeInsets.only(right: 10, left: 10),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: NeumorphicButton(
                      onPressed: () {},
                      style: NeumorphicStyle(
                          surfaceIntensity: 0.25,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(10)),
                          depth: 5,
                          lightSource: LightSource.topLeft,
                          color: Colors.white),
                      child: Center(child: Icon(Icons.search)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Obx(
                  () => GridView.builder(
                    physics: BouncingScrollPhysics(),
                      itemCount: controller.notes.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 11.0,
                          mainAxisSpacing: 11.0,
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return NeumorphicButton(
                          onPressed: () {
                            Get.to(NotePage(
                                title: controller.notes[index]['title'],
                                content: controller.notes[index]['content'],
                                id: controller.notes[index]['id']));
                          },
                          style: NeumorphicStyle(
                              surfaceIntensity: 0.25,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(10)),
                              depth: 2,
                              lightSource: LightSource.topLeft,
                              color: Colors.white),
                          child: Container(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.notes[index]['title'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: Text(controller.notes[index]
                                            ['content'])),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: NeumorphicFloatingActionButton(
          style: NeumorphicStyle(
              surfaceIntensity: 0.25,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
              depth: 5,
              lightSource: LightSource.topLeft,
              color: Colors.white),
          child: Icon(Icons.add),
          onPressed: () {
            Get.to(
                () => NotePage(
                      title: '',
                      content: '',
                      id: -1,
                    ),
                transition: Transition.rightToLeft);
          }),
    );
  }
}
