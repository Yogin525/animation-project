import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logic_practice/matrix/controller/get_controller.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {

  MatrixController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      
      child: Obx((){
        return Stack(
          children: [
            AnimatedAlign(
                  alignment: controller.isTopLeft.value ? Alignment.topLeft : Alignment.bottomRight,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FlutterLogo(size: 100),
                  ),
                ),

                Align(alignment: Alignment.bottomLeft,
                child: ElevatedButton(onPressed: controller.togglePosition, child: Text("animate")),)
          ],
          
        );
      }
       
      ),
      )
      );
  }
}
