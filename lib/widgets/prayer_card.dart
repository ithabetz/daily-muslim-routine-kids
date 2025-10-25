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
    final timeString = NumberFormatter.toEnglishNumbers(DateFormat('h:mm a').format(widget.prayer.time));
    
    return CelebrationAnimation(
      isActive: _showCelebration,
      onComplete: () => setState(() => _showCelebration = false),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(KidTheme.standardCardPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: widget.prayer.isCompleted ? Colors.green.shade200 : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Row with Icon and Prayer Info
            Row(
              children: [
                // Prayer Icon - Transparent container
                Container(
                  padding: EdgeInsets.all(KidTheme.standardIconPadding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: widget.prayer.isCompleted ? KidTheme.successGreen : Colors.grey.shade400,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    widget.prayer.type.icon,
                    color: widget.prayer.isCompleted ? KidTheme.successGreen : Colors.grey.shade600,
                    size: KidTheme.standardIconSize,
                  ),
                ),
                const SizedBox(width: 10),
                
                // Prayer info - Larger text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.prayer.type.getLocalizedName(l10n),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: widget.prayer.isCompleted 
                              ? KidTheme.successGreen
                              : KidTheme.darkBlue,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        timeString,
                        style: TextStyle(
                          fontSize: 12,
                          color: widget.prayer.isCompleted 
                              ? KidTheme.successGreen.withOpacity(0.8)
                              : KidTheme.darkBlue.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Points indicator - Transparent container
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: widget.prayer.isCompleted ? KidTheme.successGreen : Colors.grey.shade400,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '+${NumberFormatter.formatDecimal(widget.prayer.score, decimalPlaces: 1)}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: widget.prayer.isCompleted ? KidTheme.successGreen : Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 6),
            
            // Checkboxes Section - Transparent container
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: widget.prayer.isCompleted 
                      ? KidTheme.highlightPrayerBorderColor
                      : Colors.grey.shade300,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)?.completeYourPrayer ?? 'أكمل صلاتك',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: widget.prayer.isCompleted 
                          ? KidTheme.successGreen
                          : KidTheme.darkBlue,
                    ),
                  ),
                  const SizedBox(height: 3),
                  
                  // Checkboxes in a more kid-friendly layout
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: _buildKidCheckbox(
                          context: context,
                          label: AppLocalizations.of(context)?.prayedOnTime ?? 'صليت في الوقت',
                          value: widget.prayer.prayedOnTime,
                          enabled: !widget.prayer.prayedOutOfTime,
                          onChanged: (value) => _updatePrayer(context, prayedOnTime: value),
                          color: KidTheme.successGreen,
                        ),
                      ),
                      Expanded(
                        child: _buildKidCheckbox(
                          context: context,
                          label: AppLocalizations.of(context)?.inMosque ?? 'في المسجد',
                          value: widget.prayer.inMosque,
                          enabled: (widget.prayer.prayedOutOfTime || widget.prayer.prayedOnTime),
                          onChanged: (value) => _updatePrayer(context, inMosque: value),
                          color: Colors.grey.shade400,
                        ),
                      ),
                      Expanded(
                        child: _buildKidCheckbox(
                          context: context,
                          label: AppLocalizations.of(context)?.prayedOutOfTime ?? 'صليت متأخراً',
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
        const SizedBox(height: 1),
        Text(
          label,
          style: TextStyle(
            fontSize: 7,
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
                AppLocalizations.of(context)?.excellentPrayerCompleted ?? 'ممتاز! تم إنجاز الصلاة',
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