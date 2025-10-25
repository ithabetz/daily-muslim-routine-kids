import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';
import '../models/prayer.dart';
import '../models/user_profile.dart';
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
                // Prayer Icon - Standardized size
                Container(
                  padding: EdgeInsets.all(KidTheme.standardIconPadding),
                  decoration: KidTheme.getStandardIconDecoration(isCompleted: widget.prayer.isCompleted),
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
                
                // Points indicator - Standardized
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: KidTheme.getStandardPointsDecoration(isCompleted: widget.prayer.isCompleted),
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
            
            // Checkboxes Section - Just text, no box
            Column(
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
                        enabled: _isPrayedOnTimeEnabled(),
                        onChanged: (value) => _updatePrayer(context, prayedOnTime: value),
                        color: KidTheme.successGreen,
                      ),
                    ),
                    Expanded(
                      child: _buildKidCheckbox(
                        context: context,
                        label: AppLocalizations.of(context)?.inMosque ?? 'في المسجد',
                        value: widget.prayer.inMosque,
                        enabled: _isInMosqueEnabled(),
                        onChanged: (value) => _updatePrayer(context, inMosque: value),
                        color: Colors.grey.shade400,
                      ),
                    ),
                    Expanded(
                      child: _buildKidCheckbox(
                        context: context,
                        label: AppLocalizations.of(context)?.prayedOutOfTime ?? 'صليت متأخراً',
                        value: widget.prayer.prayedOutOfTime,
                        enabled: _isPrayedOutOfTimeEnabled(),
                        onChanged: (value) => _updatePrayer(context, prayedOutOfTime: value),
                        color: KidTheme.warningOrange,
                      ),
                    ),
                  ],
                ),
              ],
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

  // Helper methods to determine checkbox states based on gender and current prayer state
  bool _isPrayedOnTimeEnabled() {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final gender = provider.userProfile?.gender;
    
    // For boys: if prayed out of time, disable all other options
    if (gender == Gender.male && widget.prayer.prayedOutOfTime) {
      return false;
    }
    
    // For girls: if any other option is selected, disable this one
    if (gender == Gender.female && (widget.prayer.inMosque || widget.prayer.prayedOutOfTime)) {
      return false;
    }
    
    return true;
  }

  bool _isInMosqueEnabled() {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final gender = provider.userProfile?.gender;
    
    // For boys: if prayed out of time, disable all other options
    if (gender == Gender.male && widget.prayer.prayedOutOfTime) {
      return false;
    }
    
    // For boys: mosque option is only available if prayed on time
    if (gender == Gender.male) {
      return widget.prayer.prayedOnTime;
    }
    
    // For girls: mosque option is only available if prayed on time
    if (gender == Gender.female) {
      return widget.prayer.prayedOnTime && !widget.prayer.prayedOutOfTime;
    }
    
    // Default: mosque option is only available if prayed on time
    return widget.prayer.prayedOnTime;
  }

  bool _isPrayedOutOfTimeEnabled() {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final gender = provider.userProfile?.gender;
    
    // For boys: if prayed on time, disable out of time option
    if (gender == Gender.male && widget.prayer.prayedOnTime) {
      return false;
    }
    
    // For girls: if any other option is selected, disable this one
    if (gender == Gender.female && (widget.prayer.prayedOnTime || widget.prayer.inMosque)) {
      return false;
    }
    
    return true;
  }

  void _updatePrayer(
    BuildContext context, {
    bool? prayedOnTime,
    bool? inMosque,
    bool? prayedOutOfTime,
  }) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final wasCompleted = widget.prayer.isCompleted;
    
    // Check if prayer will be completed after this update
    // Apply the same logic as in DailyProgress.updatePrayerDetails
    bool finalPrayedOnTime = prayedOnTime ?? widget.prayer.prayedOnTime;
    bool finalInMosque = inMosque ?? widget.prayer.inMosque;
    bool finalPrayedOutOfTime = prayedOutOfTime ?? widget.prayer.prayedOutOfTime;
    
    // Apply gender-specific rules (same as in DailyProgress)
    final gender = provider.userProfile?.gender;
    
    if (gender == Gender.male && finalPrayedOutOfTime) {
      finalPrayedOnTime = false;
      finalInMosque = false;
    }
    
    if (gender == Gender.male && finalPrayedOnTime) {
      finalPrayedOutOfTime = false;
    }
    
    if (gender == Gender.male && finalInMosque && !finalPrayedOnTime) {
      finalInMosque = false;
    }
    
    if (gender == Gender.female) {
      if (finalPrayedOnTime) {
        finalInMosque = false;
        finalPrayedOutOfTime = false;
      } else if (finalInMosque) {
        finalPrayedOnTime = false;
        finalPrayedOutOfTime = false;
      } else if (finalPrayedOutOfTime) {
        finalPrayedOnTime = false;
        finalInMosque = false;
      }
    }
    
    if (gender == Gender.female && finalInMosque && !finalPrayedOnTime) {
      finalInMosque = false;
    }
    
    final willBeCompleted = finalPrayedOnTime || finalInMosque || finalPrayedOutOfTime;
    
    provider.updatePrayerDetails(
      prayerType: widget.prayer.type,
      prayedOnTime: prayedOnTime,
      inMosque: inMosque,
      prayedOutOfTime: prayedOutOfTime,
    );
    
    // Show celebration if prayer was just completed
    if (!wasCompleted && willBeCompleted) {
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