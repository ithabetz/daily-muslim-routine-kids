import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/azkar_task.dart';
import '../providers/app_provider.dart';
import '../l10n/app_localizations.dart';
import '../utils/number_formatter.dart';

class AzkarCard extends StatelessWidget {
  final AzkarTask azkar;

  const AzkarCard({super.key, required this.azkar});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: azkar.isCompleted 
            ? Colors.blue.shade50 
            : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: azkar.isCompleted 
              ? Colors.blue.shade300 
              : Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () => _toggleAzkar(context),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: azkar.isCompleted 
                  ? Colors.blue 
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              azkar.type.icon,
              color: azkar.isCompleted 
                  ? Colors.white 
                  : Colors.grey.shade600,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          
          // Azkar info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  azkar.type.getLocalizedName(l10n),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: azkar.isCompleted 
                        ? Colors.blue.shade700 
                        : Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  azkar.type.getLocalizedDescription(l10n),
                  style: TextStyle(
                    fontSize: 12,
                    color: azkar.isCompleted
                        ? Colors.blue.shade600
                        : Colors.grey.shade600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          
          // Points indicator and checkbox
          Row(
            children: [
              // Points indicator
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: azkar.isCompleted 
                      ? Colors.blue 
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '+${NumberFormatter.formatDecimal(azkar.weight, decimalPlaces: 1)}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: azkar.isCompleted 
                        ? Colors.white 
                        : Colors.grey.shade600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              
              // Checkbox
              Transform.scale(
                scale: 1.1,
                child: Checkbox(
                  value: azkar.isCompleted,
                  onChanged: (_) => _toggleAzkar(context),
                  activeColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
        ),
      ),
    );
  }

  void _toggleAzkar(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    provider.toggleAzkar(azkar.type);
  }
}
