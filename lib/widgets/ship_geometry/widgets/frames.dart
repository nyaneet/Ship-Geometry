import 'package:flutter/material.dart';
import 'package:ship_geometry/widgets/ship_geometry/ship_geometry.dart';

///
/// Creates a widget with visualization of the ship's frame
class Frame extends StatelessWidget {
  final double _width;
  final Color _color;
  const Frame({super.key, double width = 1, required Color color})
      : _width = width,
        _color = color;

  @override
  Widget build(BuildContext context) {
    return GridLine(
      direction: Direction.vertical,
      color: _color,
      thickness: _width,
    );
  }
}

///
/// Creates a widget with visualization of the ship's frames
class Frames extends StatelessWidget {
  final Color _color;
  final (double x, double y) _origin;
  final List<double> _frames;
  const Frames({
    super.key,
    Color color = Colors.black,
    required (double x, double y) origin,
    required List<double> frames,
  })  : _color = color,
        _origin = origin,
        _frames = frames;

  @override
  Widget build(BuildContext context) {
    final (originX, _) = _origin;
    return Stack(
      children: [
        ..._frames.map(
          (offsetX) => Positioned(
            top: 0,
            bottom: 0,
            left: offsetX + originX,
            child: Frame(
              width: 1,
              color: _color,
            ),
          ),
        ),
      ],
    );
  }
}
