import 'package:flutter/material.dart';

/// Animated child praying character
class PrayingChildAnimation extends StatefulWidget {
  final double size;
  final Color? color;

  const PrayingChildAnimation({
    super.key,
    this.size = 200,
    this.color,
  });

  @override
  State<PrayingChildAnimation> createState() => _PrayingChildAnimationState();
}

class _PrayingChildAnimationState extends State<PrayingChildAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(
      begin: 0.0,
      end: -20.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _bounceAnimation.value),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: _buildPrayingChild(),
          ),
        );
      },
    );
  }

  Widget _buildPrayingChild() {
    return CustomPaint(
      size: Size(widget.size, widget.size),
      painter: PrayingChildPainter(
        color: widget.color ?? Colors.white,
      ),
    );
  }
}

/// Custom painter for the praying child
class PrayingChildPainter extends CustomPainter {
  final Color color;

  PrayingChildPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Draw the child's head (circle)
    canvas.drawCircle(
      Offset(centerX, centerY - size.height * 0.15),
      size.width * 0.15,
      paint,
    );

    // Draw body (torso)
    final bodyPath = Path()
      ..moveTo(centerX - size.width * 0.1, centerY - size.height * 0.05)
      ..lineTo(centerX - size.width * 0.12, centerY + size.height * 0.15)
      ..lineTo(centerX + size.width * 0.12, centerY + size.height * 0.15)
      ..lineTo(centerX + size.width * 0.1, centerY - size.height * 0.05)
      ..close();

    canvas.drawPath(bodyPath, paint);

    // Draw praying hands
    // Left hand
    final leftHandPath = Path()
      ..addOval(Rect.fromCenter(
        center: Offset(centerX - size.width * 0.15, centerY + size.height * 0.05),
        width: size.width * 0.1,
        height: size.width * 0.08,
      ));

    canvas.drawPath(leftHandPath, paint);

    // Right hand
    final rightHandPath = Path()
      ..addOval(Rect.fromCenter(
        center: Offset(centerX + size.width * 0.15, centerY + size.height * 0.05),
        width: size.width * 0.1,
        height: size.width * 0.08,
      ));

    canvas.drawPath(rightHandPath, paint);

    // Draw legs
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = size.width * 0.03;

    // Left leg
    canvas.drawLine(
      Offset(centerX - size.width * 0.06, centerY + size.height * 0.15),
      Offset(centerX - size.width * 0.08, centerY + size.height * 0.3),
      paint,
    );

    // Right leg
    canvas.drawLine(
      Offset(centerX + size.width * 0.06, centerY + size.height * 0.15),
      Offset(centerX + size.width * 0.08, centerY + size.height * 0.3),
      paint,
    );

    // Draw feet
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(centerX - size.width * 0.08, centerY + size.height * 0.32),
      size.width * 0.04,
      paint,
    );
    canvas.drawCircle(
      Offset(centerX + size.width * 0.08, centerY + size.height * 0.32),
      size.width * 0.04,
      paint,
    );

    // Draw praying line (connection between hands)
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = size.width * 0.02;
    canvas.drawLine(
      Offset(centerX - size.width * 0.15, centerY + size.height * 0.05),
      Offset(centerX + size.width * 0.15, centerY + size.height * 0.05),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
