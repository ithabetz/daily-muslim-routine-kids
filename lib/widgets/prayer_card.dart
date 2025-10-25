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
        : 'لم يتم تحديد الوقت';
    
    return CelebrationAnimation(
      isActive: _showCelebration,
      onComplete: () => setState(() => _showCelebration = false),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(KidTheme.standardCardPadding),
        decoration: KidTheme.getStandardCardDecoration(isCompleted: widget.prayer.isCompleted),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Row with Icon and Prayer Info
            Row(
              children: [
                // Prayer Icon - Standardized size
                Container(
                  padding: EdgeInsets.all(KidTheme.standardIconPadding),
                  decoration: KidTheme.getStandardIconDecoration(isCompleted: widget.prayer.isCompleted),
                  child: Icon(
                    widget.prayer.type.icon,
                    color: Colors.white,
                    size: KidTheme.standardIconSize,
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
                
                // Points indicator - Standardized
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: KidTheme.getStandardPointsDecoration(isCompleted: widget.prayer.isCompleted),
                  child: Text(
                    '+${NumberFormatter.formatDecimal(widget.prayer.score, decimalPlaces: 1)}',
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
                  color: widget.prayer.isCompleted 
                      ? KidTheme.highlightPrayerBorderColor
                      : KidTheme.basePrayerBorderColor,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'أكمل صلاتك:',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: widget.prayer.isCompleted 
                          ? KidTheme.successGreen
                          : KidTheme.darkBlue,
                    ),
                  ),
                  const SizedBox(height: 6),
                  
                  // Checkboxes in a more kid-friendly layout
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: _buildKidCheckbox(
                          context: context,
                          label: l10n.prayedOnTime,
                          value: widget.prayer.prayedOnTime,
                          enabled: !widget.prayer.prayedOutOfTime,
                          onChanged: (value) => _updatePrayer(context, prayedOnTime: value),
                          color: KidTheme.successGreen,
                        ),
                      ),
                      Expanded(
                        child: _buildKidCheckbox(
                          context: context,
                          label: l10n.inMosque,
                          value: widget.prayer.inMosque,
                          enabled: (widget.prayer.prayedOutOfTime || widget.prayer.prayedOnTime),
                          onChanged: (value) => _updatePrayer(context, inMosque: value),
                          color: KidTheme.primaryBlue,
                        ),
                      ),
                      Expanded(
                        child: _buildKidCheckbox(
                          context: context,
                          label: l10n.prayedOutOfTime,
                          value: widget.prayer.prayedOutOfTime,
                          enabled: true,
                          onChanged: (value) => _updatePrayer(context, prayedOutOfTime: value),
                          color: KidTheme.warningOrange,
                        ),
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

  void _updatePrayer(
    BuildContext context, {
    bool? prayedOnTime,
    bool? inMosque,
    bool? prayedOutOfTime,
  }) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final wasCompleted = widget.prayer.isCompleted;
    
    provider.updatePrayerDetails(
      prayerType: widget.prayer.type,
      prayedOnTime: prayedOnTime,
      inMosque: inMosque,
      prayedOutOfTime: prayedOutOfTime,
    );
    
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
                'ممتاز! تم إكمال الصلاة! 🎉',
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