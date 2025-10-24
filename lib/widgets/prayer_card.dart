import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';
import '../models/prayer.dart';
import '../providers/app_provider.dart';
import '../utils/number_formatter.dart';
import '../theme/kid_theme.dart';
import '../widgets/celebration_animations.dart';

class PrayerCard extends StatefulWidget {
  final PrayerTask prayer;

  const PrayerCard({super.key, required this.prayer});

  @override
  State<PrayerCard> createState() => _PrayerCardState();
}

class _PrayerCardState extends State<PrayerCard> {
  bool _showCelebration = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final timeString = widget.prayer.time != null 
        ? NumberFormatter.toEnglishNumbers(DateFormat('h:mm a').format(widget.prayer.time!))
        : 'Time not set';
    
    return CelebrationAnimation(
      isActive: _showCelebration,
      onComplete: () => setState(() => _showCelebration = false),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: widget.prayer.isCompleted 
                ? [KidTheme.successGreen.withOpacity(0.1), KidTheme.successGreen.withOpacity(0.05)]
                : [Colors.white, KidTheme.lightBlueBg.withOpacity(0.3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: widget.prayer.isCompleted 
                ? KidTheme.successGreen.withOpacity(0.4)
                : KidTheme.primaryBlue.withOpacity(0.2),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.prayer.isCompleted 
                  ? KidTheme.successGreen.withOpacity(0.1)
                  : KidTheme.primaryBlue.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header Row with Icon and Prayer Info
            Row(
              children: [
                // Prayer Icon - Larger and more prominent
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: widget.prayer.isCompleted 
                        ? KidTheme.successGreen
                        : KidTheme.primaryBlue,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: (widget.prayer.isCompleted 
                            ? KidTheme.successGreen
                            : KidTheme.primaryBlue).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.prayer.type.icon,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                
                // Prayer info - Larger text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.prayer.type.getLocalizedName(l10n),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: widget.prayer.isCompleted 
                              ? KidTheme.successGreen
                              : KidTheme.darkBlue,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        timeString,
                        style: TextStyle(
                          fontSize: 16,
                          color: widget.prayer.isCompleted 
                              ? KidTheme.successGreen.withOpacity(0.8)
                              : KidTheme.darkBlue.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Points indicator - Larger and more prominent
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: widget.prayer.isCompleted 
                        ? KidTheme.successGreen
                        : KidTheme.primaryBlue,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: (widget.prayer.isCompleted 
                            ? KidTheme.successGreen
                            : KidTheme.primaryBlue).withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    '+${NumberFormatter.formatDecimal(widget.prayer.score, decimalPlaces: 1)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Checkboxes Section - Larger touch targets
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: KidTheme.primaryBlue.withOpacity(0.2),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Complete your prayer:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: KidTheme.darkBlue,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Checkboxes in a more kid-friendly layout
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildKidCheckbox(
                        context: context,
                        label: l10n.prayedOnTime,
                        value: widget.prayer.prayedOnTime,
                        enabled: !widget.prayer.prayedOutOfTime,
                        onChanged: (value) => _updatePrayer(context, prayedOnTime: value),
                        color: KidTheme.successGreen,
                      ),
                      _buildKidCheckbox(
                        context: context,
                        label: l10n.inMosque,
                        value: widget.prayer.inMosque,
                        enabled: (widget.prayer.prayedOutOfTime || widget.prayer.prayedOnTime),
                        onChanged: (value) => _updatePrayer(context, inMosque: value),
                        color: KidTheme.primaryBlue,
                      ),
                      _buildKidCheckbox(
                        context: context,
                        label: l10n.prayedOutOfTime,
                        value: widget.prayer.prayedOutOfTime,
                        enabled: true,
                        onChanged: (value) => _updatePrayer(context, prayedOutOfTime: value),
                        color: KidTheme.warningOrange,
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
      children: [
        Transform.scale(
          scale: 1.5,
          child: Checkbox(
            value: value,
            onChanged: enabled ? onChanged : null,
            activeColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            side: BorderSide(
              color: enabled ? color : Colors.grey.shade400,
              width: 3,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
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

  void _updatePrayer(
    BuildContext context, {
    bool? prayedOnTime,
    bool? inMosque,
    bool? prayedOutOfTime,
  }) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final wasCompleted = widget.prayer.isCompleted;
    
    provider.togglePrayer(widget.prayer.type);
    
    // Show celebration if prayer was just completed
    if (!wasCompleted && widget.prayer.isCompleted) {
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
                'Great job! Prayer completed! 🎉',
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