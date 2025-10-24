# المساهمة في تطبيق الروتين الإسلامي اليومي للأطفال
## Contributing to Daily Muslim Routine - Kids Version

Thank you for considering contributing to the Daily Muslim Routine Kids app! This document provides guidelines and instructions for contributors.

---

## Table of Contents
1. [Code of Conduct](#code-of-conduct)
2. [Getting Started](#getting-started)
3. [Development Workflow](#development-workflow)
4. [Coding Standards](#coding-standards)
5. [Submitting Changes](#submitting-changes)
6. [Reporting Issues](#reporting-issues)

---

## Code of Conduct

### Our Pledge
- Be respectful and inclusive
- Welcome constructive feedback
- Focus on what is best for the community
- Show empathy towards other contributors

### Islamic Values
- Maintain the integrity of Islamic teachings
- Ensure accuracy of prayer times and Islamic content
- Respect diversity of Islamic schools of thought
- Keep content appropriate and beneficial

---

## Getting Started

### Prerequisites
1. Read [README.md](README.md) for project overview
2. Read [FIREBASE_SETUP_KIDS.md](FIREBASE_SETUP_KIDS.md) for Firebase setup
3. Familiarize yourself with the Arabic-only Android app structure

### Development Setup
```bash
# Clone the repository
git clone <repository-url>
cd daily-muslim-routine-kids

# Install dependencies
flutter pub get

# Run the app (Android only)
flutter run
```

---

## Development Workflow

### 1. Find an Issue
- Check existing issues for tasks
- Look for issues labeled `good first issue` or `help wanted`
- Create a new issue if you find a bug or have an idea

### 2. Fork and Branch
```bash
# Fork the repository on GitHub
# Clone your fork
git clone <your-fork-url>

# Create a feature branch
git checkout -b feature/your-feature-name

# Or for bug fixes
git checkout -b fix/bug-description
```

### 3. Make Changes
- Write clean, maintainable code
- Follow the coding standards below
- Add comments for complex logic
- Update documentation if needed

### 4. Test Your Changes
```bash
# Run analyzer
flutter analyze

# Format code
flutter format .

# Run tests (if available)
flutter test

# Test on device/simulator
flutter run
```

### 5. Commit Changes
```bash
# Stage your changes
git add .

# Commit with descriptive message
git commit -m "feat: Add feature description"

# Or for bug fixes
git commit -m "fix: Fix bug description"
```

### 6. Push and Create Pull Request
```bash
# Push to your fork
git push origin feature/your-feature-name

# Create Pull Request on GitHub
# Provide clear description of changes
```

---

## Coding Standards

### Dart/Flutter Guidelines

#### File Organization
```dart
// 1. Package imports
import 'package:flutter/material.dart';

// 2. Relative imports
import '../models/prayer.dart';
import '../services/prayer_time_service.dart';

// 3. Class definition
class MyWidget extends StatelessWidget {
  // Constructor
  const MyWidget({super.key});
  
  // Build method
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  
  // Private helper methods
  void _privateMethod() {}
}
```

#### Naming Conventions
- **Classes:** `PascalCase` - `PrayerTask`, `HomeScreen`
- **Files:** `snake_case` - `prayer_task.dart`, `home_screen.dart`
- **Variables:** `camelCase` - `prayerTime`, `isCompleted`
- **Constants:** `SCREAMING_SNAKE_CASE` - `MAX_SCORE`
- **Private:** Prefix with `_` - `_privateMethod()`

#### Code Formatting
```bash
# Auto-format before committing
flutter format .
```

#### Documentation
```dart
/// Calculates the total daily score based on task completion.
///
/// Returns a [double] value out of 30.0 representing the sum
/// of Fard (10.0), Sunnah (10.0), and Wird (10.0) scores.
double calculateScore() {
  // Implementation
}
```

### Widget Guidelines

#### Prefer Stateless Widgets
```dart
// Good
class ScoreDisplay extends StatelessWidget {
  final double score;
  const ScoreDisplay({required this.score});
  
  @override
  Widget build(BuildContext context) => Text('$score');
}

// Avoid unless state is truly needed
class ScoreDisplay extends StatefulWidget {
  // Only if widget manages internal state
}
```

#### Use const Constructors
```dart
// Good - performance optimization
const Text('Prayer Time');
const SizedBox(height: 16);

// Avoid - creates new instance
Text('Prayer Time');
SizedBox(height: 16);
```

#### Extract Reusable Widgets
```dart
// Instead of duplicating UI code
return Column(
  children: [
    _buildSection('Fard'),
    _buildSection('Sunnah'),
    _buildSection('Wird'),
  ],
);

Widget _buildSection(String title) {
  return Container(/* ... */);
}
```

### State Management

#### Provider Pattern
```dart
// Access provider without rebuilding
final provider = Provider.of<AppProvider>(context, listen: false);

// Access with rebuilding
return Consumer<AppProvider>(
  builder: (context, provider, child) {
    return Text(provider.score.toString());
  },
);
```

### Models

#### JSON Serialization
```dart
class PrayerTask {
  // Always include toJson and fromJson
  Map<String, dynamic> toJson() {
    return {
      'type': type.toString(),
      'time': time.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  factory PrayerTask.fromJson(Map<String, dynamic> json) {
    return PrayerTask(
      type: PrayerType.values.firstWhere(
        (e) => e.toString() == json['type'],
      ),
      time: DateTime.parse(json['time']),
      isCompleted: json['isCompleted'] ?? false,
    );
  }
}
```

---

## Areas for Contribution

### High Priority
- [ ] Android platform optimization
- [ ] Enhanced error handling
- [ ] Performance improvements
- [ ] Accessibility improvements
- [ ] Unit and widget tests

### Features
- [ ] Cloud backup/sync
- [ ] Full Arabic text for azkar
- [ ] Qibla direction
- [ ] Multiple languages
- [ ] Customizable themes
- [ ] Widget support

### Documentation
- [ ] Video tutorials
- [ ] API documentation
- [ ] Code examples
- [ ] Translation of docs

### Bug Fixes
- Check issues labeled `bug`
- Test on different devices
- Reproduce and document steps

---

## Submitting Changes

### Pull Request Process

1. **Update Documentation**
   - Update README.md if adding features
   - Update FEATURES.md for new functionality
   - Update ARCHITECTURE.md for structural changes

2. **Write Good PR Description**
   ```markdown
   ## Description
   Brief description of changes

   ## Type of Change
   - [ ] Bug fix
   - [ ] New feature
   - [ ] Breaking change
   - [ ] Documentation update

   ## Testing Done
   - Tested on iPhone X (iOS 15)
   - Tested on simulator (iOS 14)
   - Verified prayer times calculation
   - Checked notification scheduling

   ## Checklist
   - [ ] Code follows project style guidelines
   - [ ] Self-review completed
   - [ ] Documentation updated
   - [ ] No new warnings
   ```

3. **Wait for Review**
   - Maintainers will review your PR
   - Address requested changes
   - Be patient and respectful

4. **Merge**
   - Once approved, your PR will be merged
   - Thank you for contributing!

### Commit Message Format
```
type: Short description (50 chars max)

Longer explanation if needed (72 chars per line)

Fixes #issue-number
```

**Types:**
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation only
- `style:` Formatting, no code change
- `refactor:` Code restructuring
- `perf:` Performance improvement
- `test:` Adding tests
- `chore:` Maintenance

**Examples:**
```bash
feat: Add Qibla direction compass

fix: Correct Fajr prayer time calculation for northern latitudes

docs: Update README with new features

refactor: Extract ring painting logic to separate class
```

---

## Reporting Issues

### Bug Reports

Use this template:
```markdown
**Describe the bug**
Clear description of what the bug is.

**To Reproduce**
Steps to reproduce:
1. Go to '...'
2. Tap on '...'
3. See error

**Expected behavior**
What you expected to happen.

**Screenshots**
If applicable, add screenshots.

**Device Info:**
- Device: [e.g. iPhone 12]
- iOS Version: [e.g. 15.0]
- App Version: [e.g. 1.0.0]

**Additional context**
Any other information about the problem.
```

### Feature Requests

Use this template:
```markdown
**Is your feature request related to a problem?**
Clear description of the problem.

**Describe the solution**
What you want to happen.

**Describe alternatives**
Other solutions you've considered.

**Additional context**
Any other context or screenshots.

**Islamic Considerations**
Any Islamic rulings or scholarly consensus to consider.
```

---

## Islamic Content Guidelines

### Prayer Times
- Verify calculation methods with Islamic scholars
- Test across different locations
- Consider edge cases (high latitudes, etc.)

### Azkar and Remembrances
- Source from authentic Islamic texts
- Provide references (Quran, Hadith)
- Include transliteration for non-Arabic speakers
- Ensure accuracy of Arabic text

### Scoring and Gamification
- Maintain Islamic priorities (Fard > Sunnah > Nafl)
- Avoid excessive competition
- Focus on consistency and sincerity
- Include reminders about intentions

---

## Testing Guidelines

### Manual Testing Checklist

#### Core Features
- [ ] App launches successfully
- [ ] Location detection works
- [ ] Prayer times display correctly
- [ ] Notifications trigger on time
- [ ] Tasks mark as complete
- [ ] Scores calculate correctly
- [ ] Activity rings animate smoothly
- [ ] History displays past days
- [ ] Settings save properly

#### Edge Cases
- [ ] New day transition at midnight
- [ ] Permission denial handling
- [ ] Network failure handling
- [ ] Invalid location entry
- [ ] App backgrounding/foregrounding

#### Devices
Test on multiple:
- iPhone models (different screen sizes)
- iOS versions (minimum iOS 13)
- Simulators and physical devices

---

## Community

### Communication Channels
- **Issues:** For bugs and feature requests
- **Pull Requests:** For code contributions
- **Discussions:** For general questions

### Recognition
Contributors will be:
- Listed in app about section (if applicable)
- Acknowledged in release notes
- Appreciated in the community

---

## Questions?

If you have questions about contributing:
1. Check existing documentation
2. Search closed issues
3. Create a new discussion
4. Be patient and respectful

---

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.

---

**جزاك الله خيرا**  
**Thank you for contributing to benefit the Muslim community!** 🤲

**Last Updated:** October 2025
