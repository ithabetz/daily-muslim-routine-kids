import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'providers/app_provider.dart';
import 'providers/locale_provider.dart';
import 'services/notification_service.dart';
import 'services/storage_service.dart';
import 'screens/setup_screen.dart';
import 'screens/main_menu_screen.dart';
import 'screens/prayers_screen.dart';
import 'screens/quran_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/profile_screen.dart';
import 'l10n/app_localizations.dart';
import 'theme/kid_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Initialize Firebase with timeout
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        // Firebase initialization timed out
        // Return a placeholder app or rethrow to handle gracefully
        throw TimeoutException('Firebase initialization timed out', const Duration(seconds: 5));
      },
    );
  } catch (e) {
    // Firebase initialization failed
    // Continue without Firebase if it fails
  }
  
  // Initialize notification service
  await NotificationService.initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, child) {
          return MaterialApp(
            title: 'الروتين الإسلامي اليومي - للأطفال',
            locale: localeProvider.locale,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ar', ''),
            ],
            theme: KidTheme.kidTheme,
            home: const AppInitializer(),
            routes: {
              '/login': (context) => const LoginScreen(),
              '/signup': (context) => const SignupScreen(),
              '/setup': (context) => const SetupScreen(),
              '/main-menu': (context) => const MainMenuScreen(),
              '/home': (context) => const PrayersScreen(),
              '/quran': (context) => const QuranScreen(),
              '/settings': (context) => const SettingsScreen(),
              '/profile': (context) => const ProfileScreen(),
            },
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  @override
  void initState() {
    super.initState();
    // Initialize app immediately without splash screen
    Future.microtask(() => _initializeApp());
  }

  Future<void> _initializeApp() async {
    // Initialize the app provider
    final provider = Provider.of<AppProvider>(context, listen: false);
    await provider.initialize(context: context);

    if (!mounted) return;

    // Check authentication status and navigate directly
    if (!provider.isAuthenticated) {
      // Check if this is first time using the app
      final isFirstLaunch = await StorageService.isFirstLaunch();
      
      if (isFirstLaunch) {
        // Show signup for first-time users
        Navigator.of(context).pushReplacementNamed('/signup');
      } else {
        // Show login for returning users
        Navigator.of(context).pushReplacementNamed('/login');
      }
    } else {
      // User is authenticated, check location
      final hasLocation = provider.isLocationSet;
      
      if (!hasLocation) {
        Navigator.of(context).pushReplacementNamed('/setup');
      } else {
        Navigator.of(context).pushReplacementNamed('/main-menu');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show a minimal loading screen while initializing
    return Scaffold(
      backgroundColor: KidTheme.primaryBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Title - Large text as shown in the image
            Text(
              'الروتين الإسلامي اليومي - للأطفال',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            
            // Subtitle - Smaller text as shown in the image
            Text(
              'تعلم الصلوات والقرآن للأطفال',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            
            // Loading indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay initialization to avoid calling setState during build
    Future.microtask(() => _initializeApp());
  }

  Future<void> _initializeApp() async {
    // Initialize the app provider
    final provider = Provider.of<AppProvider>(context, listen: false);
    await provider.initialize(context: context);

    // Small delay for splash effect
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    // Check authentication status
    if (!provider.isAuthenticated) {
      // Check if this is first time using the app
      final isFirstLaunch = await StorageService.isFirstLaunch();
      
      if (isFirstLaunch) {
        // Show signup for first-time users
        Navigator.of(context).pushReplacementNamed('/signup');
      } else {
        // Show login for returning users
        Navigator.of(context).pushReplacementNamed('/login');
      }
    } else {
      // User is authenticated, check location
      final hasLocation = provider.isLocationSet;
      
      if (!hasLocation) {
        Navigator.of(context).pushReplacementNamed('/setup');
      } else {
        Navigator.of(context).pushReplacementNamed('/main-menu');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KidTheme.primaryBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Builder(
              builder: (context) {
                final l10n = AppLocalizations.of(context);
                return Column(
                  children: [
                    Text(
                      l10n?.appTitle ?? '',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n?.appSubtitle ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 48),
            
            // Show data restoration progress if applicable
            Consumer<AppProvider>(
              builder: (context, provider, child) {
                if (provider.isRestoringData && provider.restoreStatus != null) {
                  return Column(
                    children: [
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          provider.restoreStatus!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

