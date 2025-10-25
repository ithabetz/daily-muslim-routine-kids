import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../models/prayer.dart';
import '../models/sunnah_prayer.dart';
import '../services/prayer_time_service.dart';
import '../widgets/prayer_card.dart';
import '../widgets/sunnah_prayer_card.dart';
import '../widgets/azkar_card.dart';
import '../widgets/collapsible_section.dart';
import '../widgets/base_islamic_screen.dart';
import '../widgets/unified_rings_widget.dart';
import '../l10n/app_localizations.dart';
import '../utils/date_formatter.dart';
import '../models/azkar_task.dart';
import '../theme/kid_theme.dart';

class PrayersScreen extends StatefulWidget {
  const PrayersScreen({super.key});

  @override
  State<PrayersScreen> createState() => _PrayersScreenState();
}

class _PrayersScreenState extends State<PrayersScreen> {
  @override
  void initState() {
    super.initState();
    _refreshIfNeeded();
  }

  Future<void> _refreshIfNeeded() async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    await provider.refreshDay();
    // Force refresh to ensure sunnah prayers are created
    await provider.refreshDay();
  }

  String _getKidsMessageForScore(double percentage, AppLocalizations l10n) {
    if (percentage >= 90) {
      return "ممتاز! أنت رائع! 🌟";
    } else if (percentage >= 70) {
      return "أحسنت! استمر هكذا! 👏";
    } else if (percentage >= 50) {
      return "جيد جداً! تابع التقدم! 😊";
    } else if (percentage >= 30) {
      return "لا بأس، حاول مرة أخرى! 💪";
    } else if (percentage > 0) {
      return "ابدأ يومك بالصلاة! 🤲";
    } else {
      return "ابدأ رحلتك الجميلة! 🌈";
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return BaseIslamicScreen(
      title: 'صلوات اليومية',
      header: Consumer<AppProvider>(
        builder: (context, provider, child) => _buildKidsHeader(provider),
      ),
      mainContent: Consumer<AppProvider>(
        builder: (context, provider, child) {
          final breakdown = provider.todayProgress?.getScoreBreakdown() ?? {
            'fard': 0.0, 
            'sunnah': 0.0,
            'azkar': 0.0,
            'total': 0.0
          };
          final percentages = provider.todayProgress?.getCompletionPercentages() ?? {
            'fard': 0.0, 
            'sunnah': 0.0,
            'azkar': 0.0
          };

          return ScoreCardContainer(
            title: 'تقدمك اليوم',
            content: UnifiedRingsWidget(
              configuration: ActivityRingsConfiguration(
                firstProgress: (percentages['fard'] ?? 0.0) / 100.0, // Convert percentage to 0.0-1.0
                secondProgress: (percentages['sunnah'] ?? 0.0) / 100.0, // Convert percentage to 0.0-1.0
                thirdProgress: (percentages['azkar'] ?? 0.0) / 100.0, // Convert percentage to 0.0-1.0
                firstColor: const Color(0xFF4CAF50), // Green for Fard
                secondColor: const Color(0xFFFF9800), // Orange for Sunnah
                thirdColor: const Color(0xFF2196F3), // Blue for Azkar
                firstScore: breakdown['fard'] ?? 0.0,
                secondScore: breakdown['sunnah'] ?? 0.0,
                thirdScore: breakdown['azkar'] ?? 0.0,
                totalScore: provider.todayScore,
                firstLabel: 'الفرض',
                secondLabel: 'السنة',
                thirdLabel: 'الأذكار',
                centerLabel: 'النقاط',
              ),
            ),
            bottomWidget: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Text(
                _getKidsMessageForScore(provider.todayScorePercentage, l10n),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.amber.shade800,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
      sections: Consumer<AppProvider>(
        builder: (context, provider, child) {
          if (provider.todayProgress == null) return const SizedBox.shrink();
          
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Next Prayer Info
              if (provider.prayerTimes != null) ...[
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: KidTheme.primaryBlue,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'الصلاة القادمة',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: KidTheme.darkBlue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildNextPrayerInfo(provider.prayerTimes!),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Fard Section - Five Daily Prayers
              CollapsibleSection(
                title: 'الصلوات الخمس',
                icon: Icons.mosque,
                initiallyExpanded: false,
                children: provider.todayProgress!.prayers.map((prayer) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _buildKidsPrayerCard(prayer),
                  );
                }).toList(),
              ),
              
              const SizedBox(height: 16),
              
              // Sunnah and Rawatib Section
              CollapsibleSection(
                title: 'السنن والرواتب',
                icon: Icons.star,
                initiallyExpanded: false,
                children: provider.todayProgress!.sunnahPrayers
                    .where((prayer) => _isBasicSunnahForKids(prayer))
                    .map((prayer) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: _buildKidsSunnahCard(prayer),
                  );
                }).toList(),
              ),
              
              const SizedBox(height: 16),
              
              // Azkar Section
              CollapsibleSection(
                title: 'الأذكار',
                icon: Icons.favorite,
                initiallyExpanded: false,
                children: _buildAzkarCards(),
              ),
              
            ],
          );
        },
      ),
      onRefresh: _refreshIfNeeded,
    );
  }

  Widget _buildKidsHeader(AppProvider provider) {
    final now = DateTime.now();
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [KidTheme.lightBlueBg, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: KidTheme.primaryBlue.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: KidTheme.primaryBlue,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  DateFormatter.formatDate(now, 'EEEE, MMMM d, y', context),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: KidTheme.darkBlue,
                  ),
                ),
              ),
            ],
          ),
          if (provider.city != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: KidTheme.primaryBlue,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  provider.city!,
                  style: TextStyle(
                    fontSize: 14,
                    color: KidTheme.darkBlue,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNextPrayerInfo(Map<PrayerType, DateTime> prayerTimes) {
    final now = DateTime.now();
    final nextPrayerType = PrayerTimeService.getNextPrayer(prayerTimes);
    
    if (nextPrayerType == null) return const SizedBox.shrink();
    
    final nextPrayerTime = prayerTimes[nextPrayerType]!;
    final timeUntilNext = nextPrayerTime.difference(now);
    final hours = timeUntilNext.inHours;
    final minutes = timeUntilNext.inMinutes % 60;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [KidTheme.lightBlueBg, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: KidTheme.primaryBlue.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.access_time,
            color: KidTheme.primaryBlue,
            size: 28,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الصلاة القادمة',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: KidTheme.darkBlue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${nextPrayerType.displayName} - ${DateFormat('h:mm a').format(nextPrayerTime)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: KidTheme.darkBlue,
                  ),
                ),
                if (hours > 0 || minutes > 0) ...[
                  const SizedBox(height: 4),
                  Text(
                    'في ${hours > 0 ? '$hours ساعة و ' : ''}$minutes دقيقة',
                    style: TextStyle(
                      fontSize: 12,
                      color: KidTheme.primaryBlue,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildKidsPrayerCard(PrayerTask prayer) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(KidTheme.standardCardBorderRadius),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(KidTheme.standardCardBorderRadius),
        ),
        child: PrayerCard(prayer: prayer),
      ),
    );
  }

  Widget _buildKidsSunnahCard(SunnahPrayer prayer) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(KidTheme.standardCardBorderRadius),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(KidTheme.standardCardBorderRadius),
        ),
        child: SunnahPrayerCard(prayer: prayer),
      ),
    );
  }


  List<Widget> _buildAzkarCards() {
    return [
      // Morning Azkar
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: AzkarCard(
          azkar: AzkarTask(type: AzkarType.morning),
        ),
      ),
      // Evening Azkar
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: AzkarCard(
          azkar: AzkarTask(type: AzkarType.evening),
        ),
      ),
    ];
  }

  bool _isBasicSunnahForKids(SunnahPrayer prayer) {
    // Only show sunnah prayers that actually exist (not the "no sunnah" ones)
    switch (prayer.type) {
      case SunnahPrayerType.salatAlDuha:
      case SunnahPrayerType.qiyamAlLayl:
      case SunnahPrayerType.fajrSunnahBefore:
      case SunnahPrayerType.dhuhrSunnahBefore1:
      case SunnahPrayerType.dhuhrSunnahBefore2:
      case SunnahPrayerType.dhuhrSunnahAfter:
      case SunnahPrayerType.maghribSunnahAfter:
      case SunnahPrayerType.ishaSunnahAfter:
        return true; // Show these sunnah prayers
      case SunnahPrayerType.fajrSunnahAfter:
      case SunnahPrayerType.asrSunnahBefore:
      case SunnahPrayerType.asrSunnahAfter:
      case SunnahPrayerType.maghribSunnahBefore:
      case SunnahPrayerType.ishaSunnahBefore:
        return false; // Hide these (no sunnah prayers)
    }
  }

}