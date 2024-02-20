import 'package:flutter/material.dart';

///
/// Create fake widget for visualization of the ship's body line
class BodyLineFake extends StatelessWidget {
  final (double x, double y) _origin;
  final double _thickness;
  final Color _color;
  const BodyLineFake({
    super.key,
    double thickness = 2.0,
    Color color = Colors.black,
    required (double x, double y) origin,
  })  : _origin = origin,
        _thickness = thickness,
        _color = color;

  @override
  Widget build(BuildContext context) {
    final (originX, originY) = _origin;
    final (x, y) = (25.0, 0);

    return Stack(
      children: [
        Positioned(
          left: originX + x,
          bottom: originY + y,
          child: CustomPaint(
            size: const Size(550, 150),
            painter: _BodyLineFakePainter(
              strokeWidth: _thickness,
              color: _color,
            ),
          ),
        ),
      ],
    );
  }
}

/// Paints fake body line of the ship
class _BodyLineFakePainter extends CustomPainter {
  final double _strokeWidth;
  final Color _color;
  const _BodyLineFakePainter({
    required double strokeWidth,
    required Color color,
  })  : _strokeWidth = strokeWidth,
        _color = color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _color
      ..strokeWidth = _strokeWidth;

    canvas
      ..drawLine(
        const Offset(0, 0),
        const Offset(50, 150),
        paint,
      )
      ..drawLine(
        const Offset(50, 150),
        const Offset(500, 150),
        paint,
      )
      ..drawLine(
        const Offset(500, 150),
        const Offset(550, 0),
        paint,
      )
      ..drawLine(
        const Offset(550, 0),
        const Offset(0, 0),
        paint,
      );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
