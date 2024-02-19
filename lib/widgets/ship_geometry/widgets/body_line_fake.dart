import 'package:flutter/material.dart';

///
/// Create fake widget for visualization of the ship's body line
class BodyLineFake extends StatelessWidget {
  final (double x, double y) _origin;
  const BodyLineFake({
    super.key,
    required (double x, double y) origin,
  }) : _origin = origin;

  @override
  Widget build(BuildContext context) {
    final (originX, originY) = _origin;
    final (x, y) = (25.0, 0);

    return Stack(
      children: [
        Positioned(
          left: originX + x,
          bottom: originY + y,
          child: Container(
            width: 550,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Colors.cyan,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
