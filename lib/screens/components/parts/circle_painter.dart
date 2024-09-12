import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  CirclePainter(this.basicRadius, this.maxBackRadius, this.animationRadius);

  double basicRadius;
  double maxBackRadius;
  double animationRadius;

  final MaterialAccentColor lightColor = Colors.redAccent;

  final Map<int, Map<String, double>> lightLayers = <int, Map<String, double>>{
    0: <String, double>{'maxOpacity': 0.5},
    1: <String, double>{'maxOpacity': 0.3}
  };

  ///
  @override
  void paint(Canvas canvas, Size size) {
    const Offset c = Offset.zero;

    canvas.drawCircle(
      c,
      basicRadius,
      Paint()
//        ..color = lightColor
        ..color = Colors.transparent
        ..style = PaintingStyle.fill,
    );

    double size = basicRadius;

    for (int i = 0; i < lightLayers.length; i++) {
      final Map<String, double> row = lightLayers[i]!;

      //
      double opacity = animationRadius * (row['maxOpacity']! / maxBackRadius * -1) + row['maxOpacity']!;

      //
      opacity = (opacity < 0.0) ? 0.0 : opacity;
      opacity = (opacity > 1.0) ? 1.0 : opacity;

      //
      size += animationRadius;

      //
      canvas.drawCircle(
        c,
        size,
        Paint()
          ..style = PaintingStyle.fill
          ..color = lightColor.withOpacity(opacity),
      );
    }
  }

  ///
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
