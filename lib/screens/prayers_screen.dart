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
      return l10n.excellentMessage;
    } else if (percentage >= 70) {
      return l10n.greatJobMessage;
    } else if (percentage >= 50) {
      return l10n.goodProgressMessage;
    } else if (percentage >= 30) {
      return l10n.keepTryingMessage;
    } else if (percentage > 0) {
      return l10n.startPrayerMessage;
    } else {
      return l10n.startJourneyMessage;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return BaseIslamicScreen(
      title: AppLocalizations.of(context)?.dailyRoutine ?? 'صلوات اليومية',
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

          return ScoreCardContainer(
            title: AppLocalizations.of(context)?.todayProgress ?? 'تقدمك اليوم',
            content: UnifiedRingsWidget(
              configuration: ActivityRingsConfiguration(
                firstProgress: (breakdown['fard'] ?? 0.0) / 50.0, // Fard max: 50 points
                secondProgress: (breakdown['sunnah'] ?? 0.0) / 30.0, // Sunnah max: 30 points
                thirdProgress: (breakdown['azkar'] ?? 0.0) / 20.0, // Azkar max: 20 points
                firstColor: KidTheme.fardPrayerColor,  // Green for Fard
                secondColor: KidTheme.sunnahPrayerColor, // Orange for Sunnah
                thirdColor: KidTheme.azkarPrayerColor,   // Blue for Azkar
                firstScore: breakdown['fard'] ?? 0.0,
                secondScore: breakdown['sunnah'] ?? 0.0,
                thirdScore: breakdown['azkar'] ?? 0.0,
                totalScore: provider.todayScore,
                firstLabel: AppLocalizations.of(context)?.fardLabel ?? 'الفرض',
                secondLabel: AppLocalizations.of(context)?.sunnahLabel ?? 'السنة',
                thirdLabel: AppLocalizations.of(context)?.azkarLabel ?? 'الأذكار',
                centerLabel: AppLocalizations.of(context)?.points ?? 'النقاط',
              ),
            ),
            bottomWidget: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: KidTheme.lightYellowBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: KidTheme.primaryYellow.withOpacity(0.3)),
              ),
              child: Text(
                _getKidsMessageForScore(provider.todayScorePercentage, l10n),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: KidTheme.darkOrange,
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
                            AppLocalizations.of(context)?.nextPrayer ?? 'الصلاة القادمة',
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
                title: AppLocalizations.of(context)?.fiveDailyPrayers ?? 'الصلوات الخمس',
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
                title: AppLocalizations.of(context)?.sunnahAndRawatib ?? 'السنن والرواتب',
                icon: Icons.star,
                initiallyExpanded: false,
                children: (() {
                  final sunnahPrayers = provider.todayProgress!.sunnahPrayers
                      .where((prayer) => _isBasicSunnahForKids(prayer))
                      .toList();
                  sunnahPrayers.sort((a, b) => _getSunnahPrayerOrder(a.type).compareTo(_getSunnahPrayerOrder(b.type)));
                  return sunnahPrayers.map((prayer) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: _buildKidsSunnahCard(prayer),
                    );
                  }).toList();
                })(),
              ),
              
              const SizedBox(height: 16),
              
              // Azkar Section
              CollapsibleSection(
                title: AppLocalizations.of(context)?.azkarSection ?? 'الأذكار',
                icon: Icons.favorite,
                initiallyExpanded: false,
                children: _buildAzkarCards(provider),
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
        color: Colors.white,
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
        color: Colors.white,
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
                  AppLocalizations.of(context)?.nextPrayerTime ?? 'الصلاة القادمة',
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
                    hours > 0 
                      ? AppLocalizations.of(context)?.timeUntilNext(hours, minutes) ?? 'في $hours ساعة و $minutes دقيقة'
                      : AppLocalizations.of(context)?.timeUntilNextMinutes(minutes) ?? 'في $minutes دقيقة',
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(KidTheme.standardCardBorderRadius),
      ),
      child: PrayerCard(prayer: prayer),
    );
  }

  Widget _buildKidsSunnahCard(SunnahPrayer prayer) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(KidTheme.standardCardBorderRadius),
      ),
      child: SunnahPrayerCard(prayer: prayer),
    );
  }


  List<Widget> _buildAzkarCards(AppProvider provider) {
    if (provider.todayProgress?.azkar.isEmpty ?? true) {
      return [];
    }
    
    return provider.todayProgress!.azkar
        .where((azkar) => azkar.type == AzkarType.morning || azkar.type == AzkarType.evening)
        .map((azkar) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: AzkarCard(azkar: azkar),
        ))
        .toList();
  }

  /// Get the display order for Sunnah prayers
  int _getSunnahPrayerOrder(SunnahPrayerType type) {
    switch (type) {
      case SunnahPrayerType.qiyamAlLayl:
        return 1; // قيام الليل
      case SunnahPrayerType.fajrSunnahBefore:
        return 2; // قبل الفجر (ركعتان)
      case SunnahPrayerType.salatAlDuha:
        return 3; // صلاة الضحى
      case SunnahPrayerType.dhuhrSunnahBefore1:
        return 4; // قبل الظهر (ركعتان)
      case SunnahPrayerType.dhuhrSunnahBefore2:
        return 5; // قبل الظهر (ركعتان)
      case SunnahPrayerType.dhuhrSunnahAfter:
        return 6; // بعد الظهر (ركعتان)
      case SunnahPrayerType.maghribSunnahAfter:
        return 7; // بعد المغرب (ركعتان)
      case SunnahPrayerType.ishaSunnahAfter:
        return 8; // بعد العشاء (ركعتان)
      default:
        return 999; // Other sunnah prayers at the end
    }
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