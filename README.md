# الروتين الإسلامي اليومي - للأطفال 👶
## Daily Muslim Routine - Kids Version

A comprehensive Flutter app designed specifically for children to learn and track their daily Islamic practices. This Arabic-focused Android app helps kids develop healthy Islamic habits through prayer tracking, Quran memorization, and spiritual development activities.

## 📋 App Overview

This app provides a complete Islamic daily routine tracking system for children, featuring:

- **🔐 User Management**: Secure authentication with Firebase
- **🕌 Prayer Tracking**: Five daily prayers with detailed tracking options
- **📖 Quran Learning**: Juz memorization with progress visualization
- **🎯 Scoring System**: 10-point daily scoring with visual progress rings
- **🎨 Child-Friendly UI**: Engaging animations and celebration effects
- **☁️ Cloud Sync**: Data synchronization across devices
- **🔔 Notifications**: Prayer time reminders with custom sounds
- **📍 Location Services**: GPS-based prayer time calculations

## 🌟 Features

### 🔐 User Authentication & Profile Management
- **Secure Login/Signup**: Firebase authentication with email/password
- **User Profiles**: Personal information management with gender selection
- **Location Setup**: Automatic GPS detection or manual city entry
- **Account Management**: Profile editing, logout, and account deletion
- **Cloud Sync**: Data synchronization across devices

### 🕌 Daily Prayers & Islamic Practices (صلوات اليومية)
- **Five Daily Prayers**: Track Fajr, Dhuhr, Asr, Maghrib, and Isha
- **Prayer Time Notifications**: Custom adhan notifications with prayer times
- **Prayer Tracking**: On-time, in-mosque, and out-of-time prayer tracking
- **Sunnah Prayers**: Essential sunnah prayers with completion tracking
- **Azkar (Dhikr)**: Comprehensive remembrance practices including:
  - Morning and Evening Azkar
  - Quran Reading and Listening
  - Istighfar, Salat ala Nabi, Tasbih, Tahmid
  - La Ilaha Illa Allah, Takbir, La Hawla Wa La Quwwata

### 📖 Quran Learning & Memorization (قرآن الكريم)
- **Juz Focus**: Complete Juz 28, 29, and 30 with all surahs
- **Memorization Tracking**: Mark surahs as memorized with visual feedback
- **Progress Visualization**: See memorization progress with rings and percentages
- **Child-Friendly Cards**: Large, colorful surah cards with Arabic names
- **Target Setting**: Monthly targets for Juz memorization

### 🎯 Scoring & Progress System
- **Comprehensive Scoring**: 10-point daily scoring system
  - Fard Prayers: 5.0 points maximum
  - Sunnah Prayers: 2.5 points maximum  
  - Azkar: 2.5 points maximum
- **Visual Progress Rings**: Three-ring progress visualization
- **Daily Achievements**: Celebration animations for completed tasks
- **Progress History**: Track daily progress over time

### 🎨 Child-Friendly Design & Animations
- **Bright Colors**: Engaging color scheme with teal, green, and orange
- **Large Text**: Easy-to-read fonts and buttons
- **Simple Navigation**: Clean, intuitive interface
- **Celebration Animations**: Sparkle effects and confetti for achievements
- **Encouraging Messages**: Positive feedback and motivation
- **Arabic-First**: Primary language is Arabic with English support

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK
- Android Studio (Android-only app)
- Firebase project (see FIREBASE_SETUP_KIDS.md)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd daily-muslim-routine-kids
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Setup Firebase**
   - Follow instructions in `FIREBASE_SETUP_KIDS.md`
   - Configure Firebase project for kids version
   - Add `google-services.json` to `android/app/`

4. **Run the app (Android only)**
   ```bash
   flutter run
   ```

## 📱 App Structure

### Authentication Flow
```
Login Screen → Setup Screen → Main Menu
     ↓              ↓            ↓
Signup Screen → Location Setup → App Features
```

### Comprehensive Features Table

| Feature Category | Components | Description |
|-----------------|------------|-------------|
| **Authentication** | Login, Signup, Setup | Firebase auth with location setup |
| **Prayer Tracking** | 5 Daily Prayers, Sunnah, Azkar | Complete Islamic practice tracking |
| **Quran Learning** | Juz 28-30, Surah Cards | Memorization progress tracking |
| **Scoring System** | Progress Rings, Daily Scores | 10-point comprehensive scoring |
| **Notifications** | Prayer Times, Reminders | Custom adhan notifications |
| **Data Management** | Local Storage, Cloud Sync | Offline + online data persistence |
| **UI/UX** | Animations, Celebrations | Child-friendly interface design |
| **Location Services** | GPS, Prayer Times | Accurate location-based calculations |

## 🛠️ Technical Details

### Architecture
- **State Management**: Provider pattern with comprehensive app state
- **Local Storage**: SharedPreferences for offline data persistence
- **Cloud Sync**: Firebase Firestore for data synchronization
- **Authentication**: Firebase Auth with user profile management
- **Location Services**: GPS integration for prayer time calculations
- **Notifications**: Local notifications for prayer times and reminders

### Key Services
- **AuthService**: Firebase authentication with user management
- **CloudStorageService**: Firestore integration for data sync
- **NotificationService**: Prayer time notifications with custom sounds
- **PrayerTimeService**: Adhan library integration for accurate prayer times
- **QuranMemorizationService**: Local and cloud storage for memorization progress
- **StorageService**: Local data persistence and management

### Reusable Widgets & Components
- **BaseIslamicScreen**: Common screen layout with consistent structure
- **PrayerCard**: Interactive prayer tracking with detailed options
- **SunnahPrayerCard**: Sunnah prayer tracking component
- **AzkarCard**: Dhikr practice tracking with celebration animations
- **SurahCard**: Quran memorization tracking cards
- **UnifiedRingsWidget**: Three-ring progress visualization
- **CelebrationAnimations**: Sparkle effects and confetti for achievements
- **CollapsibleSection**: Expandable sections for organized content

### Key Dependencies
```yaml
dependencies:
  flutter: sdk: flutter
  provider: ^6.1.1
  firebase_core: ^3.6.0
  firebase_auth: ^5.3.1
  cloud_firestore: ^5.4.4
  shared_preferences: ^2.2.2
  adhan: ^2.0.0+1
  geolocator: ^11.0.0
  geocoding: ^3.0.0
  flutter_local_notifications: ^17.0.0
  timezone: ^0.9.2
```

### Scoring System
- **Fard Prayers**: 5.0 points maximum (1.0 per prayer)
  - On-time prayer: 0.5 points
  - In-mosque prayer: 0.5 points (only if on-time)
  - Out-of-time prayer: 0.25 points
- **Sunnah Prayers**: 2.5 points maximum (weighted by importance)
- **Azkar**: 2.5 points maximum (weighted by practice type)
- **Total Daily Score**: 10.0 points maximum

### Comprehensive Islamic Features
- **Daily Routine Tracking**: Complete Islamic daily practices
- **Prayer Time Integration**: Accurate prayer times using Adhan library
- **Location Services**: GPS-based prayer time calculations
- **Notification System**: Prayer reminders with custom sounds
- **Cloud Synchronization**: Data backup and multi-device sync
- **Offline Support**: Full functionality without internet
- **Child Safety**: Secure authentication and data privacy
- **Educational Focus**: Learning-oriented interface design

## 🎯 Target Audience

- **Age Range**: 6-12 years old
- **Language**: Arabic speakers (with English support)
- **Learning Level**: Beginner to intermediate
- **Parental Guidance**: Designed for use with parental supervision

## 🔒 Privacy & Safety

- **Child-Safe Design**: No personal data collection beyond necessary
- **Parental Control**: Parents can monitor progress through shared accounts
- **Data Privacy**: All data is private and only accessible by authenticated users
- **Offline Support**: Works without internet connection

## 📊 Data Storage

### Local Storage
- Daily progress tracking
- Prayer completion status
- Quran memorization progress
- User preferences

### Cloud Storage (Firebase)
- User profiles
- Progress synchronization across devices
- Backup and restore functionality
- Account management

## 🎨 Design Principles

### Child-Friendly UI
- **Large Touch Targets**: Easy for small fingers
- **High Contrast**: Clear visual hierarchy
- **Consistent Colors**: Teal, green, orange theme
- **Simple Icons**: Clear, recognizable symbols

### Educational Approach
- **Positive Reinforcement**: Encouraging messages and rewards
- **Visual Progress**: Clear progress indicators
- **Arabic-First Learning**: Primary Arabic with English support
- **Gamification**: Progress rings and completion tracking

## 🚀 Future Enhancements

### Potential Features
- **Audio Recitation**: Listen to surahs with proper tajweed
- **Prayer Time Audio**: Custom adhan recordings for different regions
- **Achievement Badges**: Rewards for milestones and streaks
- **Parent Dashboard**: Progress monitoring for parents
- **Multiple Children**: Support for family accounts
- **Offline Mode**: Complete offline functionality
- **Voice Recognition**: Practice pronunciation with feedback
- **Progress Analytics**: Detailed learning analytics and reports
- **Customization**: Theme and language preferences
- **Social Features**: Share achievements with family (privacy-focused)

### Technical Improvements
- **Offline Audio**: Download surahs for offline listening
- **Advanced Notifications**: Smart reminders based on user behavior
- **Data Export**: Export progress data for backup
- **Performance Optimization**: Faster loading and smoother animations
- **Accessibility**: Enhanced support for children with special needs
- **Multi-platform**: iOS support for broader reach

## 🤝 Contributing

### Development Guidelines
- Follow Flutter best practices
- Maintain child-friendly design principles
- Ensure accessibility for children
- Test with target age group
- Keep features simple and focused

### Code Structure
```
lib/
├── main.dart                 # App entry point with routing
├── firebase_options.dart     # Firebase configuration
├── models/                   # Data models
│   ├── user_profile.dart     # User information and preferences
│   ├── daily_progress.dart   # Daily tracking with scoring
│   ├── prayer.dart          # Prayer tracking models
│   ├── azkar_task.dart      # Dhikr practice models
│   ├── sunnah_prayer.dart   # Sunnah prayer models
│   ├── quran_memorization.dart # Memorization tracking
│   ├── surah.dart           # Quran surah information
│   └── task_type.dart       # Task type definitions
├── providers/               # State management
│   ├── app_provider.dart    # Main app state provider
│   └── locale_provider.dart # Language/locale management
├── screens/                 # UI screens
│   ├── login_screen.dart    # User authentication
│   ├── signup_screen.dart   # Account creation
│   ├── setup_screen.dart    # Location setup
│   ├── main_menu_screen.dart # Main navigation
│   ├── prayers_screen.dart  # Prayer tracking
│   ├── quran_screen.dart    # Quran memorization
│   ├── profile_screen.dart  # User profile management
│   └── settings_screen.dart # App settings
├── services/               # Business logic
│   ├── auth_service.dart    # Firebase authentication
│   ├── cloud_storage_service.dart # Firestore integration
│   ├── notification_service.dart # Prayer notifications
│   ├── prayer_time_service.dart # Prayer time calculations
│   ├── quran_memorization_service.dart # Memorization logic
│   └── storage_service.dart # Local data persistence
├── widgets/                # Reusable components
│   ├── base_islamic_screen.dart # Common screen layout
│   ├── prayer_card.dart     # Prayer tracking widget
│   ├── sunnah_prayer_card.dart # Sunnah prayer widget
│   ├── azkar_card.dart      # Dhikr practice widget
│   ├── surah_card.dart      # Quran memorization widget
│   ├── unified_rings_widget.dart # Progress visualization
│   ├── celebration_animations.dart # Achievement animations
│   └── collapsible_section.dart # Expandable sections
├── theme/                   # UI theming
│   └── kid_theme.dart       # Child-friendly color scheme
├── utils/                   # Utility functions
│   ├── date_formatter.dart  # Date formatting utilities
│   └── number_formatter.dart # Number formatting
└── l10n/                   # Localization (Arabic/English)
    ├── app_ar.arb          # Arabic translations
    ├── app_localizations.dart # Generated localizations
    └── app_localizations_ar.dart # Arabic localizations
```

## 📞 Support

### Documentation
- `FIREBASE_SETUP_KIDS.md` - Firebase configuration
- `README.md` - This file
- `CONTRIBUTING.md` - Development guidelines
- Code comments for technical details

### Issues
- Report bugs through GitHub issues
- Feature requests welcome
- Security concerns: contact maintainers directly

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- **Islamic Community**: For guidance on appropriate content for children
- **Flutter Team**: For the excellent framework
- **Firebase Team**: For robust backend services
- **Contributors**: All developers who help improve the app

---

**Made with ❤️ for Muslim children around the world**

*May this app help our children grow closer to Allah and develop strong Islamic habits from a young age.*