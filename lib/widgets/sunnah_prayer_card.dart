import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/sunnah_prayer.dart';
import '../l10n/app_localizations.dart';
import '../utils/number_formatter.dart';

class SunnahPrayerCard extends StatelessWidget {
  final SunnahPrayer prayer;

  const SunnahPrayerCard({super.key, required this.prayer});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      decoration: BoxDecoration(
        color: prayer.isCompleted ? Colors.orange.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: prayer.isCompleted ? Colors.orange.shade300 : Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () => _togglePrayer(context),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Icon
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: prayer.isCompleted ? Colors.orange : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  prayer.type.icon,
                  size: 16,
                  color: prayer.isCompleted ? Colors.white : Colors.grey.shade600,
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Prayer info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      prayer.type.getLocalizedName(l10n),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: prayer.isCompleted ? Colors.orange.shade700 : Colors.black87,
                      ),
                    ),
                    Text(
                      prayer.type.getLocalizedDescription(l10n),
                      style: TextStyle(
                        fontSize: 12,
                        color: prayer.isCompleted ? Colors.orange.shade600 : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Checkbox
              Checkbox(
                value: prayer.isCompleted,
                onChanged: (_) => _togglePrayer(context),
                activeColor: Colors.orange,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              
              const SizedBox(width: 8),
              
              // Points indicator
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: prayer.isCompleted ? Colors.orange : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '+${NumberFormatter.formatDecimal(prayer.weight, decimalPlaces: 1)}',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: prayer.isCompleted ? Colors.white : Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _togglePrayer(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    provider.toggleSunnahPrayer(prayer.type);
  }
}
