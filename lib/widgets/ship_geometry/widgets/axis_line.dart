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
    final double? width = switch (_direction) {
      Direction.horizontal => null,
      Direction.vertical => 1,
    };
    final double? height = switch (_direction) {
      Direction.horizontal => 1,
      Direction.vertical => null,
    };
    final double? verticalPad = switch (_direction) {
      Direction.horizontal => null,
      Direction.vertical => 0,
    };
    final double? horizontalPad = switch (_direction) {
      Direction.horizontal => 0,
      Direction.vertical => null,
    };
    List<double> getMultiples() => List<double>.generate(
          (_size - _origin) ~/ _markInterval - (-_origin) ~/ _markInterval + 1,
          (idx) => (idx - _origin ~/ _markInterval) * _markInterval,
        );

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: verticalPad,
            bottom: verticalPad,
            left: horizontalPad,
            right: horizontalPad,
            child: GridLine(
              direction: _direction,
              color: _color,
            ),
          ),
          ...getMultiples().map(
            (v) => Positioned(
              right: switch (_direction) {
                Direction.horizontal => null,
                Direction.vertical => 0.0,
              },
              left: switch (_direction) {
                Direction.horizontal => v + _origin - _markInterval / 2,
                Direction.vertical => null,
              },
              top: switch (_direction) {
                Direction.horizontal => 0.0,
                Direction.vertical => v + _origin - _markInterval / 2,
              },
              child: SizedBox(
                height: switch (_direction) {
                  Direction.horizontal => null,
                  Direction.vertical => _markInterval,
                },
                width: switch (_direction) {
                  Direction.horizontal => _markInterval,
                  Direction.vertical => null,
                },
                child: _AxisMark(
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
    );
  }
}

class _AxisMark extends StatelessWidget {
  final double _markFontSize;
  final Direction _direction;
  final String _markText;
  final Color _color;
  const _AxisMark({
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
    final tickWithMark = [
      Text(
        _markText,
        style: TextStyle(
          fontSize: _markFontSize,
          height: 1.0,
          color: _color,
        ),
      ),
      SizedBox(
        width: switch (_direction) {
          Direction.vertical => 2.5,
          Direction.horizontal => null
        },
        height: switch (_direction) {
          Direction.vertical => null,
          Direction.horizontal => 2.5
        },
      ),
      SizedBox(
        width: switch (_direction) {
          Direction.vertical => 5.0,
          Direction.horizontal => null
        },
        height: switch (_direction) {
          Direction.vertical => null,
          Direction.horizontal => 5.0
        },
        child: GridLine(
          direction: switch (_direction) {
            Direction.horizontal => Direction.vertical,
            Direction.vertical => Direction.horizontal,
          },
          thickness: 1.0,
          color: _color,
        ),
      ),
    ];

    return Flex(
      direction: switch (_direction) {
        Direction.horizontal => Axis.vertical,
        Direction.vertical => Axis.horizontal,
      },
      crossAxisAlignment: CrossAxisAlignment.center,
      children: switch (_direction) {
        Direction.horizontal => tickWithMark.reversed.toList(),
        Direction.vertical => tickWithMark,
      },
    );
  }
}
