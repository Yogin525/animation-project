import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logic_practice/matrix/controller/get_controller.dart';

class AnimationHome extends StatefulWidget {
  const AnimationHome({super.key});

  @override
  State<AnimationHome> createState() => _AnimationHomeState();
}

class _AnimationHomeState extends State<AnimationHome> with TickerProviderStateMixin {
  final MatrixController getController = Get.put(MatrixController());

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _sizeAnimation;
  late Animation<Alignment> _alignAnimation;
  late Animation<double> _rotationAnimation;

  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _sizeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _alignAnimation = Tween<Alignment>(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );

    _isInitialized = true;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startAnimation() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    getController.toggleSize();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) return const SizedBox(); // Prevent early build

    return Scaffold(
      appBar: AppBar(title: const Text("Animation Screen")),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const SizedBox(height: 20),
              // aniContainer(),
              const SizedBox(height: 20),
              fadeSlideSizeBox(),
              const SizedBox(height: 20),
              tweenBox(),
              const SizedBox(height: 20),
              slideBox(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: startAnimation,
                child: const Text("Start Animations"),
              ),
              ElevatedButton(
                onPressed:(){
                  Get.toNamed("/second");
                },
                child: const Text("Second page"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget aniContainer() {
    return Obx(() {
      return GestureDetector(
        onTap: getController.toggleSelection,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: getController.isSelected.value ? 200 : 100,
          width: getController.isSelected.value ? 200 : 100,
          decoration: BoxDecoration(
            color: getController.isSelected.value ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(getController.isSelected.value ? 30 : 0),
          ),
          alignment: Alignment.center,
          child: Text(
            getController.isSelected.value ? 'Selected' : 'Tap',
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      );
    });
  }

  Widget fadeSlideSizeBox() {
    return SizeTransition(
      sizeFactor: _sizeAnimation,
      axisAlignment: -1.0,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            height: 100,
            width: 100,
            color: Colors.orange,
            alignment: Alignment.center,
            child: const Text(
              "Fade Slide",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget tweenBox() {
    return Obx(() {
      return TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 100.0, end: getController.targetSize.value),
        duration: const Duration(milliseconds: 500),
        builder: (context, value, child) {
          return Container(
            width: value,
            height: value,
            color: Colors.green,
            alignment: Alignment.center,
            child: const Text(
              "Tween Box",
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
    });
  }

  Widget slideBox() {
    return AlignTransition(
      alignment: _alignAnimation,
      child: RotationTransition(
        turns: _rotationAnimation,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.pink, Colors.pinkAccent],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.star, color: Colors.white),
        ),
      ),
    );
  }
}
