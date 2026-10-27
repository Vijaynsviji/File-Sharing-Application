import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ReceiverIconAnimatedView extends StatefulWidget {
  const ReceiverIconAnimatedView({Key? key}) : super(key: key);

  @override
  _RadarScannerAnimationState createState() => _RadarScannerAnimationState();
}

class _RadarScannerAnimationState extends State<ReceiverIconAnimatedView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Controls the speed of the expanding rings
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Ripple Animation & Center Button
        SizedBox(
          width: 250,
          height: 250,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 1. The Expanding Rings
              CustomPaint(
                painter: RipplePainter(_controller),
                child: const SizedBox(width: 250, height: 250),
              ),
              // 2. The Central Blue Gradient Node
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF5A8BFF), // Lighter blue
                      Color(0xFF3370FF), // Deeper blue
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    // Soft purple-blue glow exactly like the image
                    BoxShadow(
                      color: const Color(0xFF8B9FFF).withOpacity(0.4),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    '📡', // Satellite dish emoji
                    style: TextStyle(fontSize: 34),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // Bottom Status Text
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Green Dot Indicator
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFF4AD295), // Soft green
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            // Status Text
            Text(
              context.strings.scanningForDevices,
              style: context.styles.body,
            ),
          ],
        ),
      ],
    );
  }
}

// Custom Painter to handle the multi-ring stroke animations
class RipplePainter extends CustomPainter {
  final Animation<double> animation;

  RipplePainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final double maxRadius = math.min(size.width, size.height) / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    // Draw 3 expanding rings with staggered opacities and sizes
    for (int i = 1; i <= 3; i++) {
      // Offset each ring's animation start time
      double progress = (animation.value + (i * 0.33)) % 1.0;
      double currentRadius = maxRadius * progress;

      // Fade out as the ring gets larger
      double opacity = (1.0 - progress).clamp(0.0, 1.0);

      final Paint paint = Paint()
        ..color = const Color(0xFF3370FF).withOpacity(opacity * 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;

      canvas.drawCircle(center, currentRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant RipplePainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}
