import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logic_practice/matrix/controller/get_controller.dart';

class MatrixScreen extends StatelessWidget {
  MatrixScreen({super.key});

  final MatrixController controller = Get.find();
  final TextEditingController rcController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Matrix")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: rcController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "e.g. 5",
                labelText: "Enter Matrix Size",
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  int? n = int.tryParse(rcController.text);
                  if (n != null && n > 0) {
                    controller.generateMatrix(n);
                    rcController.clear();
                  }
                },
                child: const Text("Generate Matrix"),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (controller.matrix.isEmpty) return const SizedBox();

              return Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: List.generate(controller.matrix.length, (row) {
                        return Row(
                          children: List.generate(
                            controller.matrix[row].length,
                            (col) {
                              return Container(
                                width: 60,
                                height: 60,
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  color:
                                      controller.isPrime(
                                        controller.matrix[row][col],
                                      )
                                      ? Colors.purple
                                      : controller.matrix[row][col] % 2 == 0
                                      ? Colors.orange
                                      : Colors.blue,
                                ),
                                child: Center(
                                  child: Text(
                                    controller.matrix[row][col].toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              );
            }),

            txt("Odd Number color:- Blue"),
            txt("Even Number color:- Orange"),
            txt("Prime Number color:- Purple"),
          ],
        ),
      ),
    );
  }

  Widget txt(String txt) {
    return Text(txt, style: TextStyle(fontWeight: FontWeight.bold));
  }
}
