import 'package:flutter/material.dart';

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
              child: const GridLine(
                direction: Direction.vertical,
                thickness: 2,
              ),
            ),
            Positioned(
              right: 0,
              bottom: originY,
              left: 0,
              child: const GridLine(
                direction: Direction.horizontal,
                thickness: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

class FrameList extends StatelessWidget {
  final Color _color;
  final (double x, double y) _origin;
  final List<double> _frames;
  const FrameList({
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

class Bar extends StatelessWidget {
  final double _width;
  final double? _value;
  final Color _color;
  const Bar({
    super.key,
    required double width,
    double? value,
    Color color = Colors.black,
  })  : _width = width,
        _value = value,
        _color = color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _value?.abs(),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.5),
        border: Border(
          top: switch (_value) {
            null => BorderSide.none,
            double value => value >= 0
                ? BorderSide(
                    color: _color,
                    width: 5,
                  )
                : BorderSide.none,
          },
          bottom: switch (_value) {
            null => BorderSide.none,
            double value => value < 0
                ? BorderSide(
                    color: _color,
                    width: 5,
                  )
                : BorderSide.none,
          },
        ),
      ),
    );
  }
}

class BarList extends StatelessWidget {
  final (double x, double y) _origin;
  final List<(double width, double? value)> _bars;
  const BarList({
    super.key,
    required (double x, double y) origin,
    required List<(double width, double? value)> bars,
  })  : _origin = origin,
        _bars = bars;

  @override
  Widget build(BuildContext context) {
    final (originX, originY) = _origin;
    double offsetX = 0;
    return Stack(
      children: [
        ..._bars.map(
          (config) {
            final (width, value) = config;
            final bar = Positioned(
              bottom: switch (value) {
                null => originY,
                double value => value >= 0 ? originY : originY + value,
              },
              left: originX + offsetX,
              child: Bar(
                color: Colors.pink,
                width: width,
                value: value,
              ),
            );
            offsetX += width;
            return bar;
          },
        ),
      ],
    );
  }
}

class BodyLine extends StatelessWidget {
  final (double x, double y) _origin;
  const BodyLine({
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
