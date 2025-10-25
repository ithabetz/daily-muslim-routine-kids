import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/azkar_task.dart';
import '../providers/app_provider.dart';
import '../l10n/app_localizations.dart';
import '../utils/number_formatter.dart';
import '../widgets/celebration_animations.dart';

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
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: widget.azkar.isCompleted 
                ? [Colors.purple.withOpacity(0.1), Colors.purple.withOpacity(0.05)]
                : [Colors.white, Colors.purple.withOpacity(0.1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: widget.azkar.isCompleted 
                ? Colors.purple.withOpacity(0.4)
                : Colors.purple.withOpacity(0.2),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.azkar.isCompleted 
                  ? Colors.purple.withOpacity(0.1)
                  : Colors.purple.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header Row with Icon and Azkar Info
            Row(
              children: [
                // Azkar Icon - Larger and more prominent
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: widget.azkar.isCompleted 
                        ? Colors.purple
                        : Colors.purple.shade300,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.azkar.type.icon,
                    color: Colors.white,
                    size: 32,
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
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: widget.azkar.isCompleted 
                              ? Colors.purple.shade700
                              : Colors.purple.shade800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.azkar.type.getLocalizedDescription(l10n),
                        style: TextStyle(
                          fontSize: 16,
                          color: widget.azkar.isCompleted 
                              ? Colors.purple.shade600
                              : Colors.purple.shade700,
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
                    color: widget.azkar.isCompleted 
                        ? Colors.purple
                        : Colors.purple.shade300,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    '+${NumberFormatter.formatDecimal(widget.azkar.weight, decimalPlaces: 1)}',
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
                  color: Colors.purple.withOpacity(0.2),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'أكمل الأذكار:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.purple.shade800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Checkboxes in a more kid-friendly layout
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildKidCheckbox(
                        context: context,
                        label: 'أكملت الأذكار',
                        value: widget.azkar.isCompleted,
                        enabled: true,
                        onChanged: (value) => _updateAzkar(context, isCompleted: value),
                        color: Colors.purple,
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
              color: enabled ? Colors.purple.shade800 : Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  void _updateAzkar(BuildContext context, {bool? isCompleted}) {
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
                'ممتاز! تم إكمال الأذكار! 🎉',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.purple,
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