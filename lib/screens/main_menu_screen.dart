import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../theme/kid_theme.dart';
import '../widgets/celebration_animations.dart';
import 'prayers_azkar_screen.dart';
import 'quran_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('${l10n.appTitle} - Kids'),
        backgroundColor: KidTheme.primaryBlue,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: KidTheme.prayerGradient,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Welcome Message for Kids - More colorful and engaging
                Container(
                  padding: const EdgeInsets.all(24),
                  margin: const EdgeInsets.only(bottom: 32),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        KidTheme.primaryBlue.withOpacity(0.1),
                        KidTheme.primaryGreen.withOpacity(0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: KidTheme.primaryBlue.withOpacity(0.3),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: KidTheme.primaryBlue.withOpacity(0.1),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Animated welcome icon
                      PulseAnimation(
                        isActive: true,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: KidTheme.primaryBlue,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: KidTheme.primaryBlue.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.child_care,
                            size: 48,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'مرحباً! أهلاً وسهلاً',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: KidTheme.darkBlue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Welcome! Let\'s learn together! 🌟',
                        style: TextStyle(
                          fontSize: 18,
                          color: KidTheme.darkBlue,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                // Daily Prayers Card - Larger and more engaging
                _buildKidsMenuCard(
                  context: context,
                  title: 'صلوات اليومية',
                  titleEnglish: 'Daily Prayers',
                  description: 'تعلم الصلوات الخمس اليومية والأذكار',
                  descriptionEnglish: 'Learn the five daily prayers and dhikr',
                  icon: Icons.mosque,
                  color: KidTheme.primaryBlue,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PrayersAzkarScreen(),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 24),
                
                // Quran Card - Larger and more engaging
                _buildKidsMenuCard(
                  context: context,
                  title: 'قرآن الكريم',
                  titleEnglish: 'Holy Quran',
                  description: 'تعلم جزء عم مع السور الجميلة',
                  descriptionEnglish: 'Learn Juz Amma with beautiful surahs',
                  icon: Icons.menu_book,
                  color: KidTheme.primaryGreen,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const QuranScreen(),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 32),
                
                // Fun Footer for Kids - More colorful
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        KidTheme.primaryYellow.withOpacity(0.2),
                        KidTheme.primaryOrange.withOpacity(0.2),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: KidTheme.primaryYellow.withOpacity(0.4),
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PulseAnimation(
                        isActive: true,
                        child: Icon(
                          Icons.star,
                          color: KidTheme.primaryOrange,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Keep learning and growing! 🌈',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: KidTheme.darkOrange,
                        ),
                      ),
                      const SizedBox(width: 12),
                      PulseAnimation(
                        isActive: true,
                        child: Icon(
                          Icons.star,
                          color: KidTheme.primaryOrange,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildKidsMenuCard({
    required BuildContext context,
    required String title,
    required String titleEnglish,
    required String description,
    required String descriptionEnglish,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.15),
                color.withOpacity(0.08),
              ],
            ),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 2,
            ),
          ),
          child: Column(
            children: [
              // Icon Section - Larger and more prominent
              PulseAnimation(
                isActive: true,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    size: 56,
                    color: Colors.white,
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Arabic Title - Larger font
              Text(
                title,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: color.withOpacity(0.9),
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 8),
              
              // English Title - Larger font
              Text(
                titleEnglish,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: color.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              
              // Arabic Description - Larger font
              Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 8),
              
              // English Description - Larger font
              Text(
                descriptionEnglish,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  height: 1.3,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 20),
              
              // Play Button - Larger and more prominent
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Let\'s Start! 🚀',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
}