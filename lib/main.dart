import 'package:flutter/material.dart';
import 'package:ship_geometry/widgets/ship_geometry/ship_geometry.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xff272B33),
        body: Center(
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xfffaecc6),
            ),
            child: const ShipGeometry(
              width: 600,
              height: 400,
              origin: (0, 200),
              frames: [50, 100, 200, 300, 400, 500, 550],
              bars: [
                (50, null),
                (50, -25),
                (100, 50),
                (100, 75),
                (100, 85),
                (100, 50),
                (50, -50),
                (50, null),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
