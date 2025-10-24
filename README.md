# الروتين الإسلامي اليومي - للأطفال 👶
## Daily Muslim Routine - Kids Version

A simplified Flutter app designed specifically for children to learn and track their daily Islamic practices. This Arabic-focused Android app helps kids develop healthy Islamic habits through prayer tracking and Quran memorization.

## 🌟 Features

### 🕌 Daily Prayers (صلوات اليومية)
- **Five Daily Prayers**: Track Fajr, Dhuhr, Asr, Maghrib, and Isha
- **Child-Friendly Interface**: Large buttons, colorful design, simple navigation
- **Progress Tracking**: Visual progress rings showing daily completion
- **Basic Sunnah**: Essential sunnah prayers simplified for kids
- **Important Dhikr**: Core remembrance practices

### 📖 Quran Learning (قرآن الكريم)
- **Juz Amma Focus**: Complete Juz 30 (Amma) with all 37 surahs
- **Memorization Tracking**: Mark surahs as memorized with visual feedback
- **Progress Visualization**: See how many surahs you've memorized
- **Child-Friendly Cards**: Large, colorful surah cards with Arabic names

### 🎨 Child-Friendly Design
- **Bright Colors**: Engaging color scheme with teal, green, and orange
- **Large Text**: Easy-to-read fonts and buttons
- **Simple Navigation**: Clean, intuitive interface
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

### Main Menu
- **Welcome Message**: Arabic greeting for kids
- **Two Main Options**: Daily Prayers and Quran
- **Fun Footer**: Encouraging message with stars

### Daily Prayers Screen
- **Progress Header**: Visual progress rings and encouraging messages
- **Next Prayer Info**: Shows upcoming prayer time
- **Five Daily Prayers**: Interactive prayer tracking
- **Basic Sunnah**: Essential sunnah prayers
- **Important Dhikr**: Core remembrance practices

### Quran Screen
- **Juz Amma Header**: Progress tracking for memorization
- **Surah Grid**: 2x2 grid of colorful surah cards
- **Memorization Status**: Visual indicators for memorized surahs
- **Encouragement**: Motivational messages

## 🛠️ Technical Details

### Architecture
- **State Management**: Provider pattern
- **Local Storage**: SharedPreferences for offline data
- **Cloud Sync**: Firebase Firestore for data persistence
- **Authentication**: Firebase Auth for user accounts

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
  flutter_local_notifications: ^17.0.0
```

### Simplified Features
- **No Complex Features**: Removed Sadaqat, Zakat, Notes, Muhasabat Al-Nafs
- **Focused Content**: Only essential Islamic practices
- **Simplified UI**: Large buttons, clear navigation
- **Child-Safe**: No complex calculations or adult features
- **Arabic-First**: Primary language is Arabic

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
- **Audio Recitation**: Listen to surahs
- **Prayer Time Audio**: Adhan notifications
- **Achievement Badges**: Rewards for milestones
- **Parent Dashboard**: Progress monitoring for parents
- **Multiple Children**: Support for family accounts

### Technical Improvements
- **Offline Audio**: Download surahs for offline listening
- **Voice Recognition**: Practice pronunciation
- **Progress Analytics**: Detailed learning analytics
- **Customization**: Theme and language preferences

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
├── main.dart                 # App entry point
├── models/                   # Data models
├── providers/               # State management
├── screens/                 # UI screens
│   ├── main_menu_screen.dart
│   ├── prayers_screen.dart
│   └── quran_screen.dart
├── services/               # Business logic
├── widgets/                # Reusable components
└── l10n/                   # Localization (Arabic)
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