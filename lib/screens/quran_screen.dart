import 'package:flutter/material.dart';
import '../models/surah.dart';
import '../models/quran_memorization.dart';
import '../services/quran_memorization_service.dart';
import '../theme/kid_theme.dart';
import '../widgets/celebration_animations.dart';
import '../widgets/unified_rings_widget.dart';
import '../l10n/app_localizations.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  QuranMemorization _memorization = QuranMemorization();
  bool _isLoading = true;
  bool _isOfflineMode = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // Load data from local storage first for better performance
    final memorization = await QuranMemorizationService.loadMemorization();
    
    // Update monthly progress if needed
    final updatedMemorization = memorization.updateCurrentDayInMonth();
    if (updatedMemorization != memorization) {
      await QuranMemorizationService.saveMemorization(updatedMemorization);
    }
    
    if (mounted) {
      setState(() {
        _memorization = updatedMemorization;
        _isLoading = false;
      });
    }
    
    // Sync with cloud in background (non-blocking)
    _syncWithCloudInBackground();
  }

  /// Sync data with cloud in background without blocking UI
  Future<void> _syncWithCloudInBackground() async {
    try {
      await QuranMemorizationService.loadMemorization(syncWithCloud: true);
      
      // Update UI with synced data if still mounted
      if (mounted) {
        final syncedMemorization = await QuranMemorizationService.loadMemorization();
        
        setState(() {
          _memorization = syncedMemorization;
          _isOfflineMode = false; // Successfully synced
        });
      }
    } catch (e) {
      // Background sync failed
      // Mark as offline mode if sync fails
      if (mounted) {
        setState(() {
          _isOfflineMode = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)?.quranKareem ?? 'قرآن الكريم'),
          backgroundColor: KidTheme.primaryBlue,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(AppLocalizations.of(context)?.loading ?? 'جاري التحميل...'),
            ],
          ),
        ),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.quranKareem ?? 'قرآن الكريم'),
        backgroundColor: KidTheme.primaryBlue,
        foregroundColor: Colors.white,
                actions: [
                  // Sync button
                  IconButton(
                    icon: const Icon(Icons.cloud_sync),
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      
                      try {
                        await QuranMemorizationService.loadMemorization(syncWithCloud: true);
                        if (mounted) {
                          final syncedMemorization = await QuranMemorizationService.loadMemorization();
                          setState(() {
                            _memorization = syncedMemorization;
                            _isOfflineMode = false;
                            _isLoading = false;
                          });
                          
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppLocalizations.of(context)?.syncSuccess ?? 'تم المزامنة بنجاح'),
                              backgroundColor: KidTheme.primaryBlue,
                            ),
                          );
                        }
                      } catch (e) {
                        if (mounted) {
                          setState(() {
                            _isOfflineMode = true;
                            _isLoading = false;
                          });
                          
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('فشل في المزامنة: $e'),
                              backgroundColor: KidTheme.errorRed,
                            ),
                          );
                        }
                      }
                    },
                    tooltip: AppLocalizations.of(context)?.syncWithCloud ?? 'مزامنة مع السحابة',
                  ),
                  
                  // Offline mode indicator
                  if (_isOfflineMode)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: KidTheme.lightOrangeBg,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.cloud_off, size: 16, color: KidTheme.warningOrange),
                          const SizedBox(width: 4),
                          Text(
                            AppLocalizations.of(context)?.offlineMode ?? 'الوضع غير المتصل',
                            style: TextStyle(
                              fontSize: 12,
                              color: KidTheme.warningOrange,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              // Kids Header
              _buildKidsHeader(),
              
              // Content
              Expanded(
                child: _buildKidsContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKidsHeader() {
    final surahs = Surah.getJuz30Surahs();
    final memorizedCount = _memorization.getMemorizedCountForJuz(30, surahs.map((s) => s.number).toList());
    final totalSurahs = surahs.length;
    final progressPercentage = totalSurahs > 0 ? (memorizedCount / totalSurahs) * 100 : 0.0;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: KidTheme.lightBlueBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: KidTheme.primaryBlue, width: 2),
      ),
      child: Column(
        children: [
          // Juz Amma Title
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PulseAnimation(
                isActive: true,
                child: Icon(
                  Icons.menu_book,
                  color: KidTheme.primaryBlue,
                  size: 36,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'جزء عم',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: KidTheme.primaryBlue,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'من الناس إلى النبأ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: KidTheme.primaryBlue,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Progress Info with Circle
          Column(
            children: [
              Text(
                'تقدمك في الحفظ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: KidTheme.primaryBlue,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              
              // Progress Circle
              UnifiedRingsWidget(
                showSingleRing: true,
                configuration: ActivityRingsConfiguration(
                  firstProgress: progressPercentage / 100,
                  secondProgress: 0.0, // Not used for single ring
                  thirdProgress: 0.0, // Not used for single ring
                  firstColor: KidTheme.primaryBlue,
                  secondColor: KidTheme.primaryBlue, // Same color for consistency
                  thirdColor: KidTheme.primaryBlue, // Same color for consistency
                  firstScore: memorizedCount.toDouble(),
                  secondScore: 0.0,
                  thirdScore: 0.0,
                  totalScore: progressPercentage,
                  firstLabel: 'محفوظة',
                  secondLabel: '',
                  thirdLabel: '',
                  centerLabel: '%',
                ),
              ),
              
              const SizedBox(height: 12),
              
              Text(
                '$memorizedCount من $totalSurahs سورة محفوظة',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: KidTheme.primaryBlue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKidsContent() {
    final surahs = Surah.getJuz30Surahs().reversed.toList(); // Reverse the order
    
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Surahs Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.2, // Reduced from 1.5 to give more height
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: surahs.length,
            itemBuilder: (context, index) {
              final surah = surahs[index];
              final isMemorized = _memorization.isSurahMemorized(surah.number);
              
              return _buildKidsSurahCard(surah, isMemorized);
            },
          ),
          
          const SizedBox(height: 20),
          
          // Encouragement Message
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: KidTheme.lightOrangeBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: KidTheme.primaryOrange.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.star,
                  color: KidTheme.primaryOrange,
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  'استمر في الحفظ! أنت رائع!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: KidTheme.darkOrange,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'استمر في الحفظ! أنت رائع!',
                  style: TextStyle(
                    fontSize: 14,
                    color: KidTheme.darkOrange.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildKidsSurahCard(Surah surah, bool isMemorized) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () => _toggleMemorization(surah.number),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: isMemorized 
                ? [KidTheme.primaryBlue.withOpacity(0.15), KidTheme.primaryBlue.withOpacity(0.08)]
                : [KidTheme.primaryBlue.withOpacity(0.08), KidTheme.primaryBlue.withOpacity(0.04)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: isMemorized ? KidTheme.primaryBlue.withOpacity(0.4) : KidTheme.primaryBlue.withOpacity(0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: (isMemorized ? KidTheme.primaryBlue : KidTheme.primaryBlue).withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Surah Number - Smaller to save space
              PulseAnimation(
                isActive: isMemorized,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isMemorized 
                        ? [KidTheme.primaryBlue, KidTheme.primaryBlue.withOpacity(0.8)]
                        : [KidTheme.primaryBlue, KidTheme.primaryBlue.withOpacity(0.8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: (isMemorized ? KidTheme.primaryBlue : KidTheme.primaryBlue).withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '${surah.number}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              
              // Arabic Name - Smaller font
              Flexible(
                child: Text(
                  surah.nameArabic,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isMemorized ? KidTheme.primaryBlue : KidTheme.primaryBlue,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              
              // English Name - Smaller font and flexible
              Flexible(
                child: Text(
                  surah.nameEnglish,
                  style: TextStyle(
                    fontSize: 10,
                    color: isMemorized ? KidTheme.primaryBlue.withOpacity(0.8) : KidTheme.primaryBlue.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              
              // Memorized Status - Smaller and more compact
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isMemorized ? KidTheme.primaryBlue.withOpacity(0.2) : KidTheme.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isMemorized ? KidTheme.primaryBlue.withOpacity(0.4) : KidTheme.primaryBlue.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isMemorized ? Icons.check_circle : Icons.radio_button_unchecked,
                      size: 12,
                      color: isMemorized ? KidTheme.primaryBlue : KidTheme.primaryBlue,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        isMemorized ? 'محفوظة!' : 'لم تحفظ',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: isMemorized ? KidTheme.primaryBlue : KidTheme.primaryBlue,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _toggleMemorization(int surahNumber) async {
    try {
      final updatedMemorization = _memorization.toggleSurah(surahNumber);
      await QuranMemorizationService.saveMemorization(updatedMemorization);
      
      if (mounted) {
        setState(() {
          _memorization = updatedMemorization;
        });
        
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.celebration, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  updatedMemorization.isSurahMemorized(surahNumber)
                    ? 'تم حفظ السورة! 🎉 رائع!'
                    : 'تم إلغاء حفظ السورة',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            backgroundColor: KidTheme.primaryBlue,
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${AppLocalizations.of(context)?.error ?? 'خطأ'}: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}