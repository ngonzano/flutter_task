import 'package:flutter/material.dart';

class AppDonutChart extends StatelessWidget {
  final double completedPercent;

  const AppDonutChart({super.key, required this.completedPercent});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 150,
      child: CustomPaint(
        painter: DonutChartPainter(completedPercent),
        child: Center(
          child: Text(
            '${(completedPercent * 100).toStringAsFixed(0)}%',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ),
    );
  }
}

class DonutChartPainter extends CustomPainter {
  final double completedPercent;

  DonutChartPainter(this.completedPercent);

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 20.0;
    final radius = (size.width / 2) - strokeWidth;

    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCircle(center: center, radius: radius);

    final backgroundPaint =
        Paint()
          ..color = Colors.grey.shade300
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth;

    final completedPaint =
        Paint()
          ..color = Colors.blueAccent
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, 0, 2 * 3.1416, false, backgroundPaint);
    canvas.drawArc(
      rect,
      -3.1416 / 2,
      2 * 3.1416 * completedPercent,
      false,
      completedPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
