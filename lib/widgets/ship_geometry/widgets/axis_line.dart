import 'package:flutter/material.dart';
import 'package:ship_geometry/widgets/ship_geometry/ship_geometry.dart';

class AxisLine extends StatelessWidget {
  final Direction _direction;
  final double _size, _origin, _markInterval, _markFontSize;
  final Color _color;
  const AxisLine({
    super.key,
    required Direction direction,
    required double size,
    required double origin,
    double markInterval = 50.0,
    double markFontSize = 12.0,
    Color color = Colors.black,
  })  : _direction = direction,
        _size = size,
        _origin = origin,
        _markInterval = markInterval,
        _markFontSize = markFontSize,
        _color = color;

  @override
  Widget build(BuildContext context) {
    List<double> getMultiples() => List<double>.generate(
          (_size - _origin) ~/ _markInterval - (-_origin) ~/ _markInterval + 1,
          (idx) => (idx - _origin ~/ _markInterval) * _markInterval,
        );

    return RotatedBox(
      quarterTurns: switch (_direction) {
        Direction.horizontal => -1,
        Direction.vertical => 0,
      },
      child: SizedBox(
        width: 1,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              child: GridLine(
                direction: Direction.vertical,
                color: _color,
              ),
            ),
            ...getMultiples().map(
              (v) => Positioned(
                right: 0,
                top: v + _origin - _markInterval / 2,
                child: SizedBox(
                  height: _markInterval,
                  child: _AxisTickMark(
                    markFontSize: _markFontSize,
                    direction: _direction,
                    markText: (-v).toInt().toString(),
                    color: _color,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AxisTickMark extends StatelessWidget {
  final double _markFontSize;
  final Direction _direction;
  final String _markText;
  final Color _color;
  const _AxisTickMark({
    super.key,
    required double markFontSize,
    required Direction direction,
    required String markText,
    required Color color,
  })  : _markFontSize = markFontSize,
        _direction = direction,
        _markText = markText,
        _color = color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RotatedBox(
          quarterTurns: switch (_direction) {
            Direction.horizontal => 1,
            Direction.vertical => 0,
          },
          child: Text(
            _markText,
            style: TextStyle(
              fontSize: _markFontSize,
              height: 1.0,
              color: _color,
            ),
          ),
        ),
        const SizedBox(
          width: 2.5,
        ),
        SizedBox(
          width: 5.0,
          child: GridLine(
            direction: Direction.horizontal,
            thickness: 1.0,
            color: _color,
          ),
        ),
      ],
    );
  }
}
