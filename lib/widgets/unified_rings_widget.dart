import 'package:flutter/material.dart';

// Centralized color constants for all ring types
class RingColors {
  static const Color middleRingColor = Color(0xFFFF9800); // Orange - Change this to update all middle rings
  static const Color outerRingColor = Color(0xFF4CAF50);  // Green
  static const Color innerRingColor = Color(0xFF2196F3);  // Blue
}

// Configuration for activity rings
class ActivityRingsConfiguration {
  final double firstProgress;
  final double secondProgress;
  final double thirdProgress;
  final Color firstColor;
  final Color secondColor;
  final Color thirdColor;
  final double firstScore;
  final double secondScore;
  final double thirdScore;
  final double totalScore;
  final String firstLabel;
  final String secondLabel;
  final String thirdLabel;
  final String centerLabel;

  ActivityRingsConfiguration({
    required this.firstProgress,
    required this.secondProgress,
    required this.thirdProgress,
    required this.firstColor,
    required this.secondColor,
    required this.thirdColor,
    required this.firstScore,
    required this.secondScore,
    required this.thirdScore,
    required this.totalScore,
    required this.firstLabel,
    required this.secondLabel,
    required this.thirdLabel,
    required this.centerLabel,
  });
}

// Simplified unified rings widget for kids version
class UnifiedRingsWidget extends StatelessWidget {
  final ActivityRingsConfiguration configuration;
  final bool showSingleRing;

  const UnifiedRingsWidget({
    super.key,
    required this.configuration,
    this.showSingleRing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: Stack(
        children: [
          if (showSingleRing) ...[
            // Single Ring for Quran progress
            Positioned.fill(
              child: CircularProgressIndicator(
                key: ValueKey('single_${configuration.firstProgress}'),
                value: configuration.firstProgress,
                backgroundColor: configuration.firstColor.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(configuration.firstColor),
                strokeWidth: 12.0,
              ),
            ),
          ] else ...[
            // First Ring (outermost)
            Positioned.fill(
              child: CircularProgressIndicator(
                key: ValueKey('first_${configuration.firstProgress}'),
                value: configuration.firstProgress,
                backgroundColor: configuration.firstColor.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(configuration.firstColor),
                strokeWidth: 8.0,
              ),
            ),
            
            // Second Ring (middle)
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircularProgressIndicator(
                  key: ValueKey('second_${configuration.secondProgress}'),
                  value: configuration.secondProgress,
                  backgroundColor: configuration.secondColor.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(configuration.secondColor),
                  strokeWidth: 8.0,
                ),
              ),
            ),
            
            // Third Ring (innermost)
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: CircularProgressIndicator(
                  key: ValueKey('third_${configuration.thirdProgress}'),
                  value: configuration.thirdProgress,
                  backgroundColor: configuration.thirdColor.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(configuration.thirdColor),
                  strokeWidth: 8.0,
                ),
              ),
            ),
          ],
          
          // Center content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  configuration.totalScore.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  configuration.centerLabel,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Score card container for kids version
class ScoreCardContainer extends StatelessWidget {
  final String title;
  final Widget content;
  final Widget? bottomWidget;

  const ScoreCardContainer({
    super.key,
    required this.title,
    required this.content,
    this.bottomWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Colors.teal.shade50,
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            content,
            if (bottomWidget != null) ...[
              const SizedBox(height: 16),
              bottomWidget!,
            ],
          ],
        ),
      ),
    );
  }
}