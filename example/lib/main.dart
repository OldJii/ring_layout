import 'package:flutter/material.dart';
import 'package:ring_layout/ring_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      lowerBound: 0.0,
      upperBound: 1.0,
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _controller.repeat(reverse: false);
    super.initState();
  }

  Widget buildPoint({
    Color color = Colors.blue,
    double width = 50,
    double height = 50,
    BoxShape shape = BoxShape.circle,
  }) {
    return Container(
      margin: const EdgeInsets.all(2),
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration: BoxDecoration(
        boxShadow: const [BoxShadow(blurRadius: 20, color: Colors.black)],
        color: color,
        shape: shape,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(8),
            width: 400,
            height: 400,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                return RingLayout(
                  initAngle: _controller.value * 360,
                  children: List.generate(
                    10,
                    (index) =>
                        buildPoint(width: 60, height: 60, color: Colors.blue),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
