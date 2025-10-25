import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/sunnah_prayer.dart';
import '../l10n/app_localizations.dart';
import '../utils/number_formatter.dart';
import '../theme/kid_theme.dart';
import '../widgets/celebration_animations.dart';

class SunnahPrayerCard extends StatefulWidget {
  final SunnahPrayer prayer;

  const SunnahPrayerCard({super.key, required this.prayer});

  @override
  State<SunnahPrayerCard> createState() => _SunnahPrayerCardState();
}

class _SunnahPrayerCardState extends State<SunnahPrayerCard> {
  bool _showCelebration = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
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
                ? [Colors.orange.withOpacity(0.1), Colors.orange.withOpacity(0.05)]
                : [Colors.white, Colors.orange.withOpacity(0.1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: widget.prayer.isCompleted 
                ? Colors.orange.withOpacity(0.4)
                : Colors.orange.withOpacity(0.2),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.prayer.isCompleted 
                  ? Colors.orange.withOpacity(0.1)
                  : Colors.orange.withOpacity(0.1),
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
                        ? Colors.orange
                        : Colors.orange.shade300,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.3),
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
                              ? Colors.orange.shade700
                              : Colors.orange.shade800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.prayer.type.getLocalizedDescription(l10n),
                        style: TextStyle(
                          fontSize: 16,
                          color: widget.prayer.isCompleted 
                              ? Colors.orange.shade600
                              : Colors.orange.shade700,
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
                        ? Colors.orange
                        : Colors.orange.shade300,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    '+${NumberFormatter.formatDecimal(widget.prayer.weight, decimalPlaces: 1)}',
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
                  color: Colors.orange.withOpacity(0.2),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'أكمل صلاة السنة:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange.shade800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Checkboxes in a more kid-friendly layout
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildKidCheckbox(
                        context: context,
                        label: 'صليت السنة',
                        value: widget.prayer.isCompleted,
                        enabled: true,
                        onChanged: (value) => _updatePrayer(context, isCompleted: value),
                        color: Colors.orange,
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
    return Expanded(
      child: Column(
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
              color: enabled ? Colors.orange.shade800 : Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  void _updatePrayer(BuildContext context, {bool? isCompleted}) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final wasCompleted = widget.prayer.isCompleted;
    
    // Use the new value directly instead of toggling
    if (isCompleted != null) {
      provider.updateSunnahPrayer(widget.prayer.type, isCompleted);
    }
    
    // Show celebration if prayer was just completed
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
                'ممتاز! تم إكمال صلاة السنة! 🎉',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.orange,
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