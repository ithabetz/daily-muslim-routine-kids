import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/kid_theme.dart';

/// Celebration animation widget for when kids complete tasks
class CelebrationAnimation extends StatefulWidget {
  final Widget child;
  final bool isActive;
  final Duration duration;
  final VoidCallback? onComplete;

  const CelebrationAnimation({
    super.key,
    required this.child,
    this.isActive = false,
    this.duration = const Duration(seconds: 2),
    this.onComplete,
  });

  @override
  State<CelebrationAnimation> createState() => _CelebrationAnimationState();
}

class _CelebrationAnimationState extends State<CelebrationAnimation>
    with TickerProviderStateMixin {
  late AnimationController _sparkleController;
  late AnimationController _bounceController;
  late AnimationController _colorController;
  
  late Animation<double> _sparkleAnimation;
  late Animation<double> _bounceAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    
    _sparkleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _colorController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _sparkleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _sparkleController,
      curve: Curves.easeInOut,
    ));

    _bounceAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.elasticOut,
    ));

    _colorAnimation = ColorTween(
      begin: KidTheme.primaryBlue,
      end: KidTheme.primaryGreen,
    ).animate(CurvedAnimation(
      parent: _colorController,
      curve: Curves.easeInOut,
    ));

    if (widget.isActive) {
      _startAnimation();
    }
  }

  @override
  void didUpdateWidget(CelebrationAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _startAnimation();
    }
  }

  void _startAnimation() {
    _bounceController.forward().then((_) {
      _bounceController.reverse();
    });
    
    _colorController.forward().then((_) {
      _colorController.reverse();
    });
    
    _sparkleController.forward().then((_) {
      widget.onComplete?.call();
    });
  }

  @override
  void dispose() {
    _sparkleController.dispose();
    _bounceController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _sparkleController,
        _bounceController,
        _colorController,
      ]),
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Main content with bounce animation
            Transform.scale(
              scale: _bounceAnimation.value,
              child: AnimatedBuilder(
                animation: _colorAnimation,
                builder: (context, child) {
                  return ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      _colorAnimation.value ?? Colors.transparent,
                      BlendMode.modulate,
                    ),
                    child: widget.child,
                  );
                },
              ),
            ),
            
            // Sparkle effects
            if (_sparkleAnimation.value > 0)
              ...List.generate(8, (index) {
                final angle = (index * 45.0) * (math.pi / 180);
                final radius = 60.0 * _sparkleAnimation.value;
                final x = math.cos(angle) * radius;
                final y = math.sin(angle) * radius;
                
                return Positioned(
                  left: x + 100, // Center offset
                  top: y + 100,  // Center offset
                  child: Transform.scale(
                    scale: (1.0 - _sparkleAnimation.value) * 0.5 + 0.5,
                    child: Opacity(
                      opacity: 1.0 - _sparkleAnimation.value,
                      child: Icon(
                        Icons.star,
                        color: KidTheme.celebrationColors[index % KidTheme.celebrationColors.length],
                        size: 20,
                      ),
                    ),
                  ),
                );
              }),
          ],
        );
      },
    );
  }
}

/// Confetti animation widget
class ConfettiAnimation extends StatefulWidget {
  final bool isActive;
  final Duration duration;
  final VoidCallback? onComplete;

  const ConfettiAnimation({
    super.key,
    this.isActive = false,
    this.duration = const Duration(seconds: 3),
    this.onComplete,
  });

  @override
  State<ConfettiAnimation> createState() => _ConfettiAnimationState();
}

class _ConfettiAnimationState extends State<ConfettiAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  List<ConfettiParticle> particles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete?.call();
      }
    });

    if (widget.isActive) {
      _startConfetti();
    }
  }

  @override
  void didUpdateWidget(ConfettiAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _startConfetti();
    }
  }

  void _startConfetti() {
    particles.clear();
    for (int i = 0; i < 30; i++) {
      particles.add(ConfettiParticle());
    }
    _controller.forward();
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
        return CustomPaint(
          painter: ConfettiPainter(
            particles: particles,
            animationValue: _controller.value,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class ConfettiParticle {
  late double x;
  late double y;
  late double vx;
  late double vy;
  late double rotation;
  late double rotationSpeed;
  late Color color;
  late double size;

  ConfettiParticle() {
    final random = math.Random();
    x = random.nextDouble() * 400;
    y = -50;
    vx = (random.nextDouble() - 0.5) * 4;
    vy = random.nextDouble() * 3 + 2;
    rotation = random.nextDouble() * 2 * math.pi;
    rotationSpeed = (random.nextDouble() - 0.5) * 0.2;
    color = KidTheme.celebrationColors[random.nextInt(KidTheme.celebrationColors.length)];
    size = random.nextDouble() * 8 + 4;
  }

  void update() {
    x += vx;
    y += vy;
    vy += 0.1; // gravity
    rotation += rotationSpeed;
  }
}

class ConfettiPainter extends CustomPainter {
  final List<ConfettiParticle> particles;
  final double animationValue;

  ConfettiPainter({
    required this.particles,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      particle.update();
      
      final paint = Paint()
        ..color = particle.color.withOpacity(1.0 - (particle.y / size.height))
        ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(particle.x, particle.y);
      canvas.rotate(particle.rotation);
      
      // Draw different shapes
      if (particle.color == KidTheme.primaryYellow) {
        // Star shape
        _drawStar(canvas, paint, particle.size);
      } else {
        // Circle
        canvas.drawCircle(Offset.zero, particle.size / 2, paint);
      }
      
      canvas.restore();
    }
  }

  void _drawStar(Canvas canvas, Paint paint, double size) {
    final path = Path();
    final center = Offset.zero;
    final outerRadius = size / 2;
    final innerRadius = size / 4;
    
    for (int i = 0; i < 5; i++) {
      final angle = (i * 144.0) * (math.pi / 180);
      final outerX = center.dx + math.cos(angle) * outerRadius;
      final outerY = center.dy + math.sin(angle) * outerRadius;
      final innerX = center.dx + math.cos(angle + 36.0 * math.pi / 180) * innerRadius;
      final innerY = center.dy + math.sin(angle + 36.0 * math.pi / 180) * innerRadius;
      
      if (i == 0) {
        path.moveTo(outerX, outerY);
      } else {
        path.lineTo(outerX, outerY);
      }
      path.lineTo(innerX, innerY);
    }
    path.close();
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// Simple pulse animation for buttons and interactive elements
class PulseAnimation extends StatefulWidget {
  final Widget child;
  final bool isActive;
  final Duration duration;
  final double scale;

  const PulseAnimation({
    super.key,
    required this.child,
    this.isActive = false,
    this.duration = const Duration(milliseconds: 300),
    this.scale = 1.1,
  });

  @override
  State<PulseAnimation> createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<PulseAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    
    _animation = Tween<double>(
      begin: 1.0,
      end: widget.scale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    if (widget.isActive) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(PulseAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _controller.repeat(reverse: true);
    } else if (!widget.isActive && oldWidget.isActive) {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: widget.child,
        );
      },
    );
  }
}
