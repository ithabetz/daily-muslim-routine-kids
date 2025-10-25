import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/app_provider.dart';
import '../services/storage_service.dart';
import '../theme/kid_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        backgroundColor: KidTheme.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [KidTheme.lightBlueBg, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Consumer<AppProvider>(
          builder: (context, provider, child) {
          return ListView(
            children: [
              const SizedBox(height: 16),
              
              // Profile Section (only show if authenticated)
              if (provider.isAuthenticated) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    l10n.account,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: KidTheme.primaryBlue,
                    ),
                  ),
                ),
                
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: KidTheme.lightBlueBg,
                    child: provider.userProfile?.photoUrl != null
                        ? ClipOval(
                            child: Image.network(
                              provider.userProfile!.photoUrl!,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Icon(
                                Icons.person,
                                color: KidTheme.darkBlue,
                              ),
                            ),
                          )
                        : Icon(
                            Icons.person,
                            color: Colors.teal.shade700,
                          ),
                  ),
                  title: Text(provider.userProfile?.displayName ?? l10n.user),
                  subtitle: Text(provider.userProfile?.email ?? ''),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.of(context).pushNamed('/profile');
                  },
                ),
                
                // Sync with Cloud button
                ListTile(
                  leading: Icon(Icons.cloud_sync, color: KidTheme.primaryBlue),
                  title: Text(AppLocalizations.of(context)?.syncWithCloud ?? 'مزامنة مع السحابة'),
                  subtitle: Text(AppLocalizations.of(context)?.syncWithCloudDescription ?? 'تحميل البيانات من السحابة'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () async {
                    // Show loading dialog
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AlertDialog(
                        content: Row(
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(width: 16),
                            Text(AppLocalizations.of(context)?.syncing ?? 'جاري المزامنة...'),
                          ],
                        ),
                      ),
                    );
                    
                    try {
                      await provider.loadFromCloud();
                      if (context.mounted) {
                        Navigator.of(context).pop(); // Close loading dialog
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(AppLocalizations.of(context)?.syncSuccess ?? 'تم المزامنة بنجاح!'),
                            backgroundColor: KidTheme.successGreen,
                          ),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        Navigator.of(context).pop(); // Close loading dialog
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('فشل في المزامنة: $e'),
                            backgroundColor: KidTheme.errorRed,
                          ),
                        );
                      }
                    }
                  },
                ),
                
                const Divider(),
              ],
              
              // Location Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  l10n.location,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: KidTheme.primaryBlue,
                  ),
                ),
              ),
              
              ListTile(
                leading: const Icon(Icons.location_city),
                title: Text(l10n.city),
                subtitle: Text(provider.city ?? l10n.notSet),
                trailing: const Icon(Icons.edit),
                onTap: () => _showChangeLocationDialog(context, provider),
              ),
              
              
              const Divider(),
              
              // About Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  l10n.about,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: KidTheme.primaryBlue,
                  ),
                ),
              ),
              
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(l10n.version),
                subtitle: Text(l10n.appVersion),
              ),
              
              ListTile(
                leading: const Icon(Icons.description),
                title: Text(l10n.about),
                subtitle: Text(l10n.aboutApp),
              ),
              
              const Divider(),
              
              // Data Management
              ListTile(
                leading: Icon(Icons.delete_outline, color: KidTheme.errorRed),
                title: Text(l10n.clearAllData),
                onTap: () => _showClearDataDialog(context),
              ),
              
              const SizedBox(height: 32),
            ],
          );
          },
        ),
      ),
    );
  }

  void _showChangeLocationDialog(BuildContext context, AppProvider provider) {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController(text: provider.city ?? '');
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.changeLocation),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: l10n.cityName,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                // Use approximate coordinates (should use geocoding in production)
                await provider.setLocation(
                  city: controller.text,
                  latitude: provider.latitude ?? 24.7136,
                  longitude: provider.longitude ?? 46.6753,
                );
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.locationUpdated)),
                  );
                }
              }
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }


  void _showClearDataDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final provider = Provider.of<AppProvider>(context, listen: false);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.clearAllDataQuestion),
        content: Text(
          provider.isAuthenticated
              ? l10n.clearDataWarningAuth
              : l10n.clearDataWarningNoAuth,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () async {
              await StorageService.clearAllData();
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.localDataCleared)),
                );
                
                // Refresh the app
                if (provider.isAuthenticated) {
                  await provider.initialize(context: context);
                } else {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/setup',
                    (route) => false,
                  );
                }
              }
            },
            style: TextButton.styleFrom(foregroundColor: KidTheme.errorRed),
            child: Text(l10n.clear),
          ),
        ],
      ),
    );
  }
}

