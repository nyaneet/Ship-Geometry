import 'package:flutter/material.dart';

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
                    width: 1,
                  )
                : BorderSide.none,
          },
          bottom: switch (_value) {
            null => BorderSide.none,
            double value => value < 0
                ? BorderSide(
                    color: _color,
                    width: 1,
                  )
                : BorderSide.none,
          },
        ),
      ),
    );
  }
}

class Bars extends StatelessWidget {
  final (double x, double y) _origin;
  final List<(double width, double? value)> _bars;
  const Bars({
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
