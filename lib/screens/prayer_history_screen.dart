import 'package:flutter/material.dart';
import '../models/daily_progress.dart';
import '../models/sunnah_prayer.dart';
import '../services/storage_service.dart';
import '../theme/kid_theme.dart';
import '../l10n/app_localizations.dart';
import '../utils/date_formatter.dart';

class PrayerHistoryScreen extends StatefulWidget {
  const PrayerHistoryScreen({super.key});

  @override
  State<PrayerHistoryScreen> createState() => _PrayerHistoryScreenState();
}

class _PrayerHistoryScreenState extends State<PrayerHistoryScreen> {
  List<DailyProgress> _history = [];
  bool _isLoading = true;
  int _daysToShow = 7; // Default to last 7 days

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final allProgress = await StorageService.loadAllDailyProgress();
      final now = DateTime.now();
      
      // Filter to last N days and sort by date descending
      _history = allProgress
          .where((progress) {
            final daysDiff = now.difference(progress.date).inDays;
            return daysDiff >= 0 && daysDiff < _daysToShow;
          })
          .toList();
      
      _history.sort((a, b) => b.date.compareTo(a.date));
    } catch (e) {
      // Handle error
      _history = [];
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KidTheme.primaryBlue,
        foregroundColor: Colors.white,
        title: Text(l10n.prayerHistory),
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.filter_list),
            onSelected: (value) {
              setState(() {
                _daysToShow = value;
                _loadHistory();
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 7,
                child: Text(l10n.last7Days),
              ),
              PopupMenuItem(
                value: 14,
                child: Text(l10n.last14Days),
              ),
              PopupMenuItem(
                value: 30,
                child: Text(l10n.last30Days),
              ),
            ],
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _history.isEmpty
              ? _buildEmptyState(l10n)
              : _buildHistoryList(l10n),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 64,
            color: KidTheme.primaryBlue.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.noHistoryFound,
            style: TextStyle(
              fontSize: 18,
              color: KidTheme.darkBlue.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList(AppLocalizations l10n) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _history.length,
      itemBuilder: (context, index) {
        final progress = _history[index];
        return _buildHistoryCard(progress, l10n);
      },
    );
  }

  Widget _buildHistoryCard(DailyProgress progress, AppLocalizations l10n) {
    final isToday = progress.date.year == DateTime.now().year &&
        progress.date.month == DateTime.now().month &&
        progress.date.day == DateTime.now().day;

    final breakdown = progress.getScoreBreakdown();
    final totalScore = progress.getTotalScore();
    final completionRate = (totalScore / 100) * 100;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isToday 
              ? KidTheme.primaryBlue 
              : KidTheme.primaryBlue.withOpacity(0.2),
          width: isToday ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date and Score
            Row(
              children: [
                Icon(
                  isToday ? Icons.today : Icons.calendar_today,
                  color: KidTheme.primaryBlue,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    DateFormatter.formatDate(progress.date, 'EEEE, MMMM d, y', context),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: KidTheme.darkBlue,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getScoreColor(completionRate).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${totalScore.toInt()} ${l10n.points}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _getScoreColor(completionRate),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Progress Breakdown
            Row(
              children: [
                Expanded(
                  child: _buildMiniProgressBar(
                    l10n.fardLabel,
                    breakdown['fard'] ?? 0.0,
                    50.0,
                    KidTheme.fardPrayerColor,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildMiniProgressBar(
                    l10n.sunnahLabel,
                    breakdown['sunnah'] ?? 0.0,
                    30.0,
                    KidTheme.sunnahPrayerColor,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildMiniProgressBar(
                    l10n.azkarLabel,
                    breakdown['azkar'] ?? 0.0,
                    20.0,
                    KidTheme.azkarPrayerColor,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Completion Status for all categories
            _buildCompletionStatus(progress, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniProgressBar(String label, double value, double max, Color color) {
    final percentage = (value / max).clamp(0.0, 1.0);
    
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: KidTheme.darkBlue.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 4),
        Stack(
          children: [
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            FractionallySizedBox(
              widthFactor: percentage,
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCompletionStatus(DailyProgress progress, AppLocalizations l10n) {
    // Count completed prayers
    final completedPrayers = progress.prayers.where((p) => p.isCompleted).length;
    final totalPrayers = progress.prayers.length;
    
    // Count completed Sunnah prayers (only the basic ones for kids)
    final basicSunnahTypes = [
      SunnahPrayerType.qiyamAlLayl,
      SunnahPrayerType.fajrSunnahBefore,
      SunnahPrayerType.salatAlDuha,
      SunnahPrayerType.dhuhrSunnahBefore1,
      SunnahPrayerType.dhuhrSunnahBefore2,
      SunnahPrayerType.dhuhrSunnahAfter,
      SunnahPrayerType.maghribSunnahAfter,
      SunnahPrayerType.ishaSunnahAfter,
    ];
    final completedSunnah = progress.sunnahPrayers
        .where((p) => basicSunnahTypes.contains(p.type) && p.isCompleted)
        .length;
    final totalSunnah = basicSunnahTypes.length;
    
    // Count completed Azkar
    final completedAzkar = progress.azkar.where((a) => a.isCompleted).length;
    final totalAzkar = progress.azkar.length;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: _buildStatusItem(
            Icons.mosque,
            completedPrayers,
            totalPrayers,
            l10n.prayers,
            KidTheme.fardPrayerColor,
          ),
        ),
        Container(width: 1, height: 30, color: KidTheme.lightGray.withOpacity(0.3)),
        Expanded(
          child: _buildStatusItem(
            Icons.star,
            completedSunnah,
            totalSunnah,
            l10n.sunnahLabel,
            KidTheme.sunnahPrayerColor,
          ),
        ),
        Container(width: 1, height: 30, color: KidTheme.lightGray.withOpacity(0.3)),
        Expanded(
          child: _buildStatusItem(
            Icons.favorite,
            completedAzkar,
            totalAzkar,
            l10n.azkarLabel,
            KidTheme.azkarPrayerColor,
          ),
        ),
      ],
    );
  }
  
  Widget _buildStatusItem(IconData icon, int completed, int total, String label, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: color,
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          '$completed/$total',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: KidTheme.darkBlue,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: KidTheme.darkBlue.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Color _getScoreColor(double percentage) {
    if (percentage >= 90) {
      return KidTheme.primaryGreen;
    } else if (percentage >= 70) {
      return KidTheme.primaryBlue;
    } else if (percentage >= 50) {
      return KidTheme.primaryYellow;
    } else {
      return KidTheme.darkOrange;
    }
  }
}

