import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/app_provider.dart';
import '../services/storage_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Consumer<AppProvider>(
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
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ),
                
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal.shade100,
                    child: provider.userProfile?.photoUrl != null
                        ? ClipOval(
                            child: Image.network(
                              provider.userProfile!.photoUrl!,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Icon(
                                Icons.person,
                                color: Colors.teal.shade700,
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
                  leading: const Icon(Icons.cloud_sync, color: Colors.blue),
                  title: const Text('مزامنة مع السحابة'),
                  subtitle: const Text('تحميل البيانات من السحابة'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () async {
                    // Show loading dialog
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const AlertDialog(
                        content: Row(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(width: 16),
                            Text('جاري المزامنة...'),
                          ],
                        ),
                      ),
                    );
                    
                    try {
                      await provider.loadFromCloud();
                      if (context.mounted) {
                        Navigator.of(context).pop(); // Close loading dialog
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تم المزامنة بنجاح!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        Navigator.of(context).pop(); // Close loading dialog
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('فشل في المزامنة: $e'),
                            backgroundColor: Colors.red,
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
                    color: Colors.teal,
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
                    color: Colors.teal,
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
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: Text(l10n.clearAllData),
                onTap: () => _showClearDataDialog(context),
              ),
              
              const SizedBox(height: 32),
            ],
          );
        },
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
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(l10n.clear),
          ),
        ],
      ),
    );
  }
}

