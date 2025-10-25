import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../services/prayer_time_service.dart';
import '../l10n/app_localizations.dart';
import '../theme/kid_theme.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final _cityController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _detectLocation() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final position = await PrayerTimeService.getCurrentLocation();
      if (position == null) {
        setState(() {
          _errorMessage = l10n.unableToAccessLocation;
          _isLoading = false;
        });
        return;
      }

      final city = await PrayerTimeService.getCityFromLocation(position);
      if (city == null) {
        setState(() {
          _errorMessage = l10n.unableToDetermineCity;
          _isLoading = false;
        });
        return;
      }

      if (!mounted) return;
      
      final provider = Provider.of<AppProvider>(context, listen: false);
      await provider.setLocation(
        city: city,
        latitude: position.latitude,
        longitude: position.longitude,
      );

      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/main-menu');
    } catch (e) {
      setState(() {
        _errorMessage = '${l10n.error}: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  Future<void> _saveManualLocation() async {
    final l10n = AppLocalizations.of(context)!;
    if (_cityController.text.isEmpty) {
      setState(() {
        _errorMessage = l10n.pleaseEnterCityName;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // For manual entry, we'll use approximate coordinates
    // In a production app, you'd want to geocode the city name
    final provider = Provider.of<AppProvider>(context, listen: false);
    
    // Default to a reasonable location (this should be improved with geocoding)
    await provider.setLocation(
      city: _cityController.text,
      latitude: 24.7136,
      longitude: 46.6753,
    );

    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed('/main-menu');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: KidTheme.lightBlueBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.mosque,
                size: 80,
                color: Colors.teal,
              ),
              const SizedBox(height: 24),
              Text(
                l10n.welcomeToApp,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                l10n.setupLocationDesc,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _detectLocation,
                icon: const Icon(Icons.my_location),
                label: Text(l10n.detectMyLocation),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
              ),
              
              const SizedBox(height: 24),
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(l10n.or),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 24),
              
              TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: l10n.enterYourCity,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.location_city),
                ),
                enabled: !_isLoading,
              ),
              
              const SizedBox(height: 16),
              
              ElevatedButton(
                onPressed: _isLoading ? null : _saveManualLocation,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
                child: Text(l10n.continueButton),
              ),
              
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Center(child: CircularProgressIndicator()),
                ),
              
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

