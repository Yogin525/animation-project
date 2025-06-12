import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logic_practice/matrix/controller/get_controller.dart';

class ColorMatrix extends StatefulWidget {
  const ColorMatrix({super.key});

  @override
  State<ColorMatrix> createState() => _ColorMatrixState();
}

class _ColorMatrixState extends State<ColorMatrix> {
  final TextEditingController _controller = TextEditingController();
  final MatrixController controller = Get.find();

  int matrixSize = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Matrix")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            txtField("Enter matrix size", "e.g. 5"),
            const SizedBox(height: 16),
            btn(() {
              FocusScope.of(context).unfocus();
              final input = int.tryParse(_controller.text);
              if (input != null && input > 0) {
                controller.updateMatrixSize(input);
              }
              _controller.clear();
            }, "Build Matrix"),

            const SizedBox(height: 16),
            listcell(),
            btn(controller.clearHighlights, "Clear highLights")
          ],
        ),
      ),
    );
  }

  Widget txtField(String label, String hint) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget btn(VoidCallback onPressed, String label) {
    return ElevatedButton(onPressed: onPressed, child: Text(label));
  }

 Widget listcell() {
  return Obx(() {
    if (controller.matrixSize.value > 0) {
      return Expanded(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: controller.matrixSize.value,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemCount: controller.matrixSize.value * controller.matrixSize.value,
          itemBuilder: (context, index) {
            final row = index ~/ controller.matrixSize.value;
            final col = index % controller.matrixSize.value;

            return Obx(() {
              bool isHighlighted = controller.highlightedCells.contains('$row,$col');
              bool isTapped = controller.tappedCells.contains('$row,$col');

              return GestureDetector(
                onTap: () {
                  controller.selectCell(row, col);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isHighlighted ? Colors.red : Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: isTapped
                      ? const Text(
                          '0',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      : null,
                ),
              );
            });
          },
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  });
}
}
