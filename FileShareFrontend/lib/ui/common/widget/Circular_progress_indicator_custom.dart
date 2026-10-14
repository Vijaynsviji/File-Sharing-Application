import 'dart:math';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/global/models/app_colors.dart';
import 'package:flutter/material.dart';

class CircularProgressIndicatorCustom extends StatelessWidget {
  /// The progress value between 0.0 and 1.0 (e.g., 0.80 for 80%)
  final double value;

  /// The width and height dimensions of the circular indicator
  final double size;

  /// The thickness of both the background ring and the progress indicator line
  final double strokeWidth;

  const CircularProgressIndicatorCustom({
    super.key,
    required this.value,
    this.size = 100.0, // Increased default size to fit text comfortably
    this.strokeWidth = 12.0, // Thicker stroke to match the image
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _GradientCircularProgressPainter(
          value: value / 100,
          strokeWidth: strokeWidth,
          // Fallback to a default blue gradient if context.colors.grad isn't available
          gradient: context.colors.grad is SweepGradient
              ? context.colors.grad as SweepGradient
              : const SweepGradient(
                  colors: [Color(0xFF5A72EA), Color(0xFF40C4FF)],
                  startAngle: -pi / 2,
                  endAngle: 3 * pi / 2,
                ),
          trackColor: context.colors.track ?? const Color(0xFFF0F0F0),
        ),
        child: Center(
          child: Text(
            '${(value).toStringAsFixed(2)}%',
            style: context.styles.listTitle,
          ),
        ),
      ),
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  final double value;
  final double strokeWidth;
  final Gradient gradient;
  final Color trackColor;

  _GradientCircularProgressPainter({
    required this.value,
    required this.strokeWidth,
    required this.gradient,
    required this.trackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // 1. Draw the background track (light gray)
    final backgroundPaint = Paint()
      ..color = trackColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, backgroundPaint);

    // 2. Draw the gradient progress arc
    final rect = Rect.fromCircle(center: center, radius: radius);
    final progressPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // 👈 This creates the rounded ends

    // Start at the top center (-90 degrees)
    const startAngle = -pi / 2;
    // Calculate how far the arc should sweep based on the value
    final sweepAngle = 2 * pi * value;

    canvas.drawArc(rect, startAngle, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _GradientCircularProgressPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.gradient != gradient ||
        oldDelegate.trackColor != trackColor;
  }
}
