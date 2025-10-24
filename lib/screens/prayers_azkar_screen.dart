import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../models/prayer.dart';
import '../models/azkar_task.dart';
import '../models/sunnah_prayer.dart';
import '../services/prayer_time_service.dart';
import '../widgets/prayer_card.dart';
import '../widgets/azkar_card.dart';
import '../widgets/sunnah_prayer_card.dart';
import '../widgets/base_islamic_screen.dart';
import '../widgets/unified_rings_widget.dart';
import '../l10n/app_localizations.dart';
import '../utils/date_formatter.dart';

class PrayersAzkarScreen extends StatefulWidget {
  const PrayersAzkarScreen({super.key});

  @override
  State<PrayersAzkarScreen> createState() => _PrayersAzkarScreenState();
}

class _PrayersAzkarScreenState extends State<PrayersAzkarScreen> {
  @override
  void initState() {
    super.initState();
    _refreshIfNeeded();
  }

  Future<void> _refreshIfNeeded() async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    await provider.refreshDay();
  }

  String _getKidsMessageForScore(double percentage, AppLocalizations l10n) {
    if (percentage >= 90) {
      return "ممتاز! أنت رائع! 🌟\nExcellent! You're amazing!";
    } else if (percentage >= 70) {
      return "أحسنت! استمر هكذا! 👏\nGreat job! Keep it up!";
    } else if (percentage >= 50) {
      return "جيد جداً! تابع التقدم! 😊\nVery good! Keep progressing!";
    } else if (percentage >= 30) {
      return "لا بأس، حاول مرة أخرى! 💪\nIt's okay, try again!";
    } else if (percentage > 0) {
      return "ابدأ يومك بالصلاة! 🤲\nStart your day with prayers!";
    } else {
      return "ابدأ رحلتك الجميلة! 🌈\nBegin your beautiful journey!";
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return BaseIslamicScreen(
      title: 'صلوات اليومية - Daily Prayers',
      header: Consumer<AppProvider>(
        builder: (context, provider, child) => _buildKidsHeader(provider),
      ),
      mainContent: Consumer<AppProvider>(
        builder: (context, provider, child) {
          final breakdown = provider.todayProgress?.getScoreBreakdown() ?? {
            'fard': 0.0, 
            'sunnah': 0.0, 
            'wird': 0.0,
            'total': 0.0
          };
          final percentages = provider.todayProgress?.getCompletionPercentages() ?? {
            'fard': 0.0, 
            'sunnah': 0.0, 
            'wird': 0.0
          };

          return ScoreCardContainer(
            title: 'تقدمك اليوم - Your Progress Today',
            content: UnifiedRingsWidget(
              configuration: ActivityRingsConfiguration(
                firstProgress: percentages['fard'] ?? 0.0,
                secondProgress: percentages['sunnah'] ?? 0.0,
                thirdProgress: percentages['wird'] ?? 0.0,
                firstColor: const Color(0xFF4CAF50), // Green for Fard
                secondColor: const Color(0xFFFF9800), // Orange for Sunnah
                thirdColor: const Color(0xFF2196F3), // Blue for Wird
                firstScore: breakdown['fard'] ?? 0.0,
                secondScore: breakdown['sunnah'] ?? 0.0,
                thirdScore: breakdown['wird'] ?? 0.0,
                totalScore: provider.todayScore,
                firstLabel: 'الفرض - Fard',
                secondLabel: 'السنة - Sunnah',
                thirdLabel: 'الورد - Wird',
                centerLabel: 'النقاط - Points',
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
                _buildNextPrayerInfo(provider.prayerTimes!),
                const SizedBox(height: 24),
              ],

              // Fard Section - Five Daily Prayers
              _buildKidsSection(
                title: 'الصلوات الخمس - Five Daily Prayers',
                icon: Icons.mosque,
                color: Colors.teal,
                children: provider.todayProgress!.prayers.map((prayer) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildKidsPrayerCard(prayer),
                  );
                }).toList(),
              ),
              
              const SizedBox(height: 24),
              
              // Basic Sunnah Section - Simplified for Kids
              _buildKidsSection(
                title: 'السنن المهمة - Important Sunnah',
                icon: Icons.star,
                color: Colors.orange,
                children: provider.todayProgress!.sunnahPrayers
                    .where((prayer) => _isBasicSunnahForKids(prayer))
                    .map((prayer) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _buildKidsSunnahCard(prayer),
                  );
                }).toList(),
              ),
              
              const SizedBox(height: 24),
              
              // Basic Azkar Section - Simplified for Kids
              _buildKidsSection(
                title: 'الأذكار المهمة - Important Dhikr',
                icon: Icons.favorite,
                color: Colors.pink,
                children: provider.todayProgress!.azkar
                    .where((azkar) => _isBasicAzkarForKids(azkar))
                    .map((azkar) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _buildKidsAzkarCard(azkar),
                  );
                }).toList(),
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
          colors: [Colors.teal.shade100, Colors.teal.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Colors.teal.shade700,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  DateFormatter.formatDate(now, 'EEEE, MMMM d, y', context),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal.shade800,
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
                  color: Colors.teal.shade600,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  provider.city!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.teal.shade700,
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
          colors: [Colors.blue.shade100, Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          Icon(
            Icons.access_time,
            color: Colors.blue.shade700,
            size: 28,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الصلاة القادمة - Next Prayer',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${nextPrayerType.displayName} - ${DateFormat('h:mm a').format(nextPrayerTime)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
                if (hours > 0 || minutes > 0) ...[
                  const SizedBox(height: 4),
                  Text(
                    'في ${hours > 0 ? '$hours ساعة و ' : ''}$minutes دقيقة',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue.shade700,
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

  Widget _buildKidsSection({
    required String title,
    required IconData icon,
    required Color color,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: color.withOpacity(0.7),
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildKidsPrayerCard(PrayerTask prayer) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              Colors.teal.withOpacity(0.05),
              Colors.teal.withOpacity(0.02),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: PrayerCard(prayer: prayer),
      ),
    );
  }

  Widget _buildKidsSunnahCard(SunnahPrayer prayer) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.orange.withOpacity(0.02),
        ),
        child: SunnahPrayerCard(prayer: prayer),
      ),
    );
  }

  Widget _buildKidsAzkarCard(AzkarTask azkar) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.pink.withOpacity(0.02),
        ),
        child: AzkarCard(azkar: azkar),
      ),
    );
  }

  bool _isBasicSunnahForKids(SunnahPrayer prayer) {
    // Only include essential sunnah prayers for kids
    final basicSunnahTypes = [
      'duha', // Morning prayer
      'qiyam', // Night prayer
    ];
    return basicSunnahTypes.any((type) => 
        prayer.type.toString().toLowerCase().contains(type));
  }

  bool _isBasicAzkarForKids(AzkarTask azkar) {
    // Only include basic, essential azkar for kids
    final basicAzkarTypes = [
      'morning',
      'evening',
      'tasbih',
      'istighfar',
    ];
    return basicAzkarTypes.any((type) => 
        azkar.type.toString().toLowerCase().contains(type));
  }
}