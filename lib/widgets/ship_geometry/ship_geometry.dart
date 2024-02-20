import 'package:flutter/material.dart';
import 'package:ship_geometry/widgets/ship_geometry/widgets/bars.dart';
import 'package:ship_geometry/widgets/ship_geometry/widgets/body_line_fake.dart';
import 'package:ship_geometry/widgets/ship_geometry/widgets/frames.dart';

enum Direction {
  vertical,
  horizontal,
}

///
/// Creates vertical or horizontal line
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
    return CustomPaint(
      size: Size(
        switch (_direction) {
          Direction.vertical => _thickness,
          Direction.horizontal => double.infinity,
        },
        switch (_direction) {
          Direction.vertical => double.infinity,
          Direction.horizontal => _thickness,
        },
      ),
      painter: _GridLinePainter(
        color: _color,
        thickness: _thickness,
        direction: _direction,
      ),
    );
  }
}

class _GridLinePainter extends CustomPainter {
  final Color _color;
  final double _thickness;
  final Direction _direction;
  const _GridLinePainter({
    required Color color,
    required double thickness,
    required Direction direction,
  })  : _color = color,
        _thickness = thickness,
        _direction = direction;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..isAntiAlias = false
      ..color = _color
      ..strokeWidth = _thickness;
    canvas.drawLine(
      Offset(
        switch (_direction) {
          Direction.horizontal => 0,
          Direction.vertical => size.width / 2,
        },
        switch (_direction) {
          Direction.horizontal => size.height / 2,
          Direction.vertical => 0,
        },
      ),
      Offset(
        switch (_direction) {
          Direction.horizontal => size.width,
          Direction.vertical => size.width / 2,
        },
        switch (_direction) {
          Direction.horizontal => size.height / 2,
          Direction.vertical => size.height,
        },
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MarkedGridLine extends StatelessWidget {
  final Direction _direction;
  final Color _color;
  final double _thickness, _width;
  final String _mark;
  const MarkedGridLine({
    super.key,
    required Direction direction,
    required String mark,
    Color color = Colors.black,
    double thickness = 1,
    double width = 20,
  })  : _direction = direction,
        _mark = mark,
        _color = color,
        _thickness = thickness,
        _width = width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Text(_mark),
            ),
          ),
          Flexible(
            flex: 1,
            child: GridLine(
              direction: _direction,
              thickness: _thickness,
              color: _color,
            ),
          ),
        ],
      ),
    );
  }
}

///
/// Сreates a widget with visualization of the ship geometry
class ShipGeometry extends StatelessWidget {
  final double _width, _height;
  final (double x, double y) _origin;
  final List<double> _frames;
  final List<(double, double?)> _bars;
  final Color _bodyColor, _barColor, _frameColor;
  const ShipGeometry({
    super.key,
    double width = 0.0,
    double height = 0.0,
    (double, double) origin = (0, 0),
    Color bodyColor = Colors.black,
    Color barColor = Colors.black,
    Color frameColor = Colors.black,
    bool showGrid = false,
    required List<double> frames,
    required List<(double, double?)> bars,
  })  : _width = width,
        _height = height,
        _origin = origin,
        _bodyColor = bodyColor,
        _barColor = barColor,
        _frameColor = frameColor,
        _frames = frames,
        _bars = bars;

  double _xTransformed(double x) => x + _origin.$1;
  double _yTransformed(double y) => y + _origin.$2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: _width,
        height: _height,
        child: Stack(
          children: [
            // Testing GridLine
            Positioned(
              top: 0.0,
              bottom: 0.0,
              left: _xTransformed(0.0),
              child: const GridLine(
                direction: Direction.vertical,
                thickness: 1.0,
              ),
            ),
            Positioned(
              right: 0.0,
              bottom: _yTransformed(-15.0),
              left: 0.0,
              child: const MarkedGridLine(
                direction: Direction.horizontal,
                thickness: 1.0,
                width: 30,
                mark: '0',
              ),
            ),
            Positioned(
              right: 0.0,
              bottom: _yTransformed(50.0 - 15.0),
              left: 0.0,
              child: const MarkedGridLine(
                direction: Direction.horizontal,
                thickness: 1.0,
                width: 30,
                mark: '1',
              ),
            ),
            Positioned(
              right: 0.0,
              bottom: _yTransformed(100.0 - 15.0),
              left: 0.0,
              child: const MarkedGridLine(
                direction: Direction.horizontal,
                thickness: 1.0,
                width: 30,
                mark: '2',
              ),
            ),
            Positioned(
              right: 0.0,
              bottom: _yTransformed(150.0 - 15.0),
              left: 0.0,
              child: const MarkedGridLine(
                direction: Direction.horizontal,
                thickness: 1.0,
                width: 30,
                mark: '3',
              ),
            ),
            BodyLineFake(
              origin: _origin,
              color: _bodyColor,
            ),
            Bars(
              origin: _origin,
              bars: _bars,
              color: _barColor,
            ),
            Frames(
              origin: _origin,
              frames: _frames,
              color: _frameColor,
            ),
          ],
        ),
      ),
    );
  }
}
