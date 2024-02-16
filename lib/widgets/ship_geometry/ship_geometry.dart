import 'package:flutter/material.dart';
import 'package:ship_geometry/widgets/ship_geometry/bars.dart';
import 'package:ship_geometry/widgets/ship_geometry/body_line.dart';
import 'package:ship_geometry/widgets/ship_geometry/frames.dart';

enum Direction {
  vertical,
  horizontal,
}

class GridLine extends StatelessWidget {
  final Direction _direction;
  final Color _color;
  final double _thickness;
  const GridLine({
    super.key,
    required Direction direction,
    Color color = Colors.black,
    double thickness = 1,
  })  : _direction = direction,
        _color = color,
        _thickness = thickness;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: switch (_direction) {
        Direction.vertical => _thickness,
        Direction.horizontal => double.infinity,
      },
      height: switch (_direction) {
        Direction.vertical => double.infinity,
        Direction.horizontal => _thickness,
      },
      decoration: BoxDecoration(
        color: _color,
      ),
    );
  }
}

class ShipGeometry extends StatelessWidget {
  final double _width, _height;
  final (double x, double y) _origin;
  final List<double> _frames;
  final List<(double, double?)> _bars;
  const ShipGeometry({
    super.key,
    double width = 0.0,
    double height = 0.0,
    (double, double) origin = (0, 0),
    required List<double> frames,
    required List<(double, double?)> bars,
  })  : _width = width,
        _height = height,
        _origin = origin,
        _frames = frames,
        _bars = bars;

  @override
  Widget build(BuildContext context) {
    final (originX, originY) = _origin;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: _width,
        height: _height,
        child: Stack(
          children: [
            BodyLine(
              origin: _origin,
            ),
            BarList(
              origin: _origin,
              bars: _bars,
            ),
            FrameList(
              origin: _origin,
              color: Colors.blue,
              frames: _frames,
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: originX,
              child: const GridLine(direction: Direction.vertical),
            ),
            Positioned(
              right: 0,
              bottom: originY,
              left: 0,
              child: const GridLine(direction: Direction.horizontal),
            ),
          ],
        ),
      ),
    );
  }
}
