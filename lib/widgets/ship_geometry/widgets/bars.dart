import 'package:flutter/material.dart';

///
/// Сreates a widget with bar visualization of shear and moment diagram
class Bar extends StatelessWidget {
  final double _width;
  final double? _value;
  final Color _color;
  const Bar({
    super.key,
    required double width,
    required Color color,
    double? value,
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

///
/// Сreates a widget with visualization of shear and moment diagram
class Bars extends StatelessWidget {
  final (double x, double y) _origin;
  final List<(double width, double? value)> _bars;
  final Color _color;
  const Bars({
    super.key,
    required (double x, double y) origin,
    required List<(double width, double? value)> bars,
    Color color = Colors.black,
  })  : _origin = origin,
        _bars = bars,
        _color = color;

  @override
  Widget build(BuildContext context) {
    final (originX, originY) = _origin;
    double offsetX = 0;
    return Stack(
      children: [
        ..._bars.map(
          (barConfig) {
            final (width, value) = barConfig;
            final bar = Positioned(
              bottom: switch (value) {
                null => originY,
                double value => value >= 0 ? originY : originY + value,
              },
              left: originX + offsetX,
              child: Bar(
                color: _color,
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
