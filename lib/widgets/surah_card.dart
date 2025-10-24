import 'package:flutter/material.dart';
import '../models/surah.dart';
import '../l10n/app_localizations.dart';

class SurahCard extends StatelessWidget {
  final Surah surah;
  final VoidCallback? onTap;
  final bool isMemorized;
  final ValueChanged<bool?>? onMemorizationChanged;

  const SurahCard({
    super.key,
    required this.surah,
    this.onTap,
    this.isMemorized = false,
    this.onMemorizationChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isMemorized 
            ? Colors.green.shade50 
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isMemorized 
              ? Colors.green.shade300 
              : Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
            children: [
              // Surah Number Circle
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isMemorized 
                      ? Colors.green.shade100 
                      : Colors.green.shade50,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isMemorized 
                        ? Colors.green.shade600 
                        : Colors.green.shade300,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    '${surah.number}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isMemorized 
                          ? Colors.green.shade800 
                          : Colors.green.shade700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              
              // Surah Details
              Expanded(
                child: InkWell(
                  onTap: onTap,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Arabic Name
                      Text(
                        surah.nameArabic,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Amiri',
                          color: isMemorized 
                              ? Colors.green.shade700 
                              : Colors.black,
                        ),
                      ),
                    const SizedBox(height: 4),
                    
                      // Secondary line: hide transliteration in Arabic locale to avoid Latin text
                      if (!isArabic)
                        Text(
                          '${surah.transliteration} - ${surah.nameEnglish}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      const SizedBox(height: 4),
                      
                      // Ayahs count and Revelation type
                      Row(
                        children: [
                          Icon(
                            Icons.menu_book,
                            size: 14,
                            color: isMemorized 
                                ? Colors.green.shade600 
                                : Colors.grey.shade500,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${surah.numberOfAyahs} ${l10n.verses}',
                            style: TextStyle(
                              fontSize: 12,
                              color: isMemorized 
                                  ? Colors.green.shade600 
                                  : Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: surah.revelationType == 'Meccan'
                                  ? Colors.amber.shade50
                                  : Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              surah.revelationType == 'Meccan'
                                  ? l10n.meccan
                                  : l10n.medinan,
                              style: TextStyle(
                                fontSize: 11,
                                color: surah.revelationType == 'Meccan'
                                    ? Colors.amber.shade800
                                    : Colors.blue.shade800,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              // Memorization Checkbox
              Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  value: isMemorized,
                  onChanged: onMemorizationChanged,
                  activeColor: Colors.green.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

