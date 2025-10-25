import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/azkar_task.dart';
import '../providers/app_provider.dart';
import '../l10n/app_localizations.dart';
import '../utils/number_formatter.dart';
import '../widgets/celebration_animations.dart';
import '../theme/kid_theme.dart';

class AzkarCard extends StatefulWidget {
  final AzkarTask azkar;

  const AzkarCard({super.key, required this.azkar});

  @override
  State<AzkarCard> createState() => _AzkarCardState();
}

class _AzkarCardState extends State<AzkarCard> {
  bool _showCelebration = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return CelebrationAnimation(
      isActive: _showCelebration,
      onComplete: () => setState(() => _showCelebration = false),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(KidTheme.standardCardPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: widget.azkar.isCompleted ? Colors.green.shade200 : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Row with Icon and Azkar Info
            Row(
              children: [
                // Azkar Icon - Standardized size
                Container(
                  padding: EdgeInsets.all(KidTheme.standardIconPadding),
                  decoration: KidTheme.getStandardIconDecoration(isCompleted: widget.azkar.isCompleted),
                  child: Icon(
                    widget.azkar.type.icon,
                    color: Colors.white,
                    size: KidTheme.standardIconSize,
                  ),
                ),
                const SizedBox(width: 16),
                
                // Azkar info - Larger text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.azkar.type.getLocalizedName(l10n),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: widget.azkar.isCompleted 
                              ? KidTheme.successGreen
                              : KidTheme.darkBlue,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.azkar.type.getLocalizedDescription(l10n),
                        style: TextStyle(
                          fontSize: 14,
                          color: widget.azkar.isCompleted 
                              ? KidTheme.successGreen.withOpacity(0.8)
                              : KidTheme.darkBlue.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Points indicator - Standardized
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: KidTheme.getStandardPointsDecoration(isCompleted: widget.azkar.isCompleted),
                  child: Text(
                    '+${NumberFormatter.formatDecimal(widget.azkar.weight, decimalPlaces: 1)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Checkboxes Section - Standardized
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: widget.azkar.isCompleted 
                      ? KidTheme.highlightPrayerBorderColor
                      : KidTheme.basePrayerBorderColor,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.completeAzkar,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: widget.azkar.isCompleted 
                          ? KidTheme.successGreen
                          : KidTheme.darkBlue,
                    ),
                  ),
                  const SizedBox(height: 6),
                  
                  // Checkboxes in a more kid-friendly layout
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildKidCheckbox(
                        context: context,
                        label: l10n.completedAzkar,
                        value: widget.azkar.isCompleted,
                        enabled: true,
                        onChanged: (value) => _updateAzkar(context, isCompleted: value),
                        color: KidTheme.successGreen,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKidCheckbox({
    required BuildContext context,
    required String label,
    required bool value,
    required bool enabled,
    required ValueChanged<bool?> onChanged,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.scale(
          scale: 1.1,
          child: Checkbox(
            value: value,
            onChanged: enabled ? onChanged : null,
            activeColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            side: BorderSide(
              color: enabled ? color : Colors.grey.shade400,
              width: 2,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w500,
            color: enabled ? KidTheme.darkBlue : Colors.grey.shade600,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  void _updateAzkar(BuildContext context, {bool? isCompleted}) {
    final l10n = AppLocalizations.of(context)!;
    final provider = Provider.of<AppProvider>(context, listen: false);
    final wasCompleted = widget.azkar.isCompleted;
    
    // Use the new value directly instead of toggling
    if (isCompleted != null) {
      provider.updateAzkar(widget.azkar.type, isCompleted);
    }
    
    // Show celebration if azkar was just completed
    if (!wasCompleted && isCompleted == true) {
      setState(() {
        _showCelebration = true;
      });
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.celebration, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                l10n.excellentAzkarCompleted,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          backgroundColor: KidTheme.successGreen,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }
}