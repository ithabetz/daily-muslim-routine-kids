import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../l10n/app_localizations.dart';
import '../theme/kid_theme.dart';
import '../utils/date_formatter.dart';
import '../models/user_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _isEditing = false;
  bool _isSaving = false;
  Gender? _selectedGender;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final provider = Provider.of<AppProvider>(context, listen: false);
    _nameController.text = provider.userProfile?.displayName ?? '';
    _selectedGender = provider.userProfile?.gender;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _isSaving = true;
    });

    try {
      final provider = Provider.of<AppProvider>(context, listen: false);
      await provider.updateProfile(
        displayName: _nameController.text.trim(),
        gender: _selectedGender,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.profileUpdatedSuccessfully),
          backgroundColor: KidTheme.successGreen,
        ),
      );

      setState(() {
        _isEditing = false;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)?.errorWithMessage(e.toString()) ?? '${l10n.failedToUpdateProfile}: $e'),
          backgroundColor: KidTheme.errorRed,
        ),
      );
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  Future<void> _handleLogout() async {
    final l10n = AppLocalizations.of(context)!;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.logout),
        content: Text(l10n.areYouSureLogout),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: KidTheme.errorRed,
              foregroundColor: Colors.white,
            ),
            child: Text(l10n.logout),
          ),
        ],
      ),
    );

    if (confirm == true) {
      if (!mounted) return;

      try {
        final provider = Provider.of<AppProvider>(context, listen: false);
        await provider.signOut();

        if (!mounted) return;

        Navigator.of(context).pushNamedAndRemoveUntil(
          '/login',
          (route) => false,
        );
      } catch (e) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)?.errorWithMessage(e.toString()) ?? '${l10n.error}: $e'),
            backgroundColor: KidTheme.errorRed,
          ),
        );
      }
    }
  }

  Future<void> _handleDeleteAccount() async {
    final l10n = AppLocalizations.of(context)!;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteAccount),
        content: Text(l10n.deleteAccountWarning),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
            ),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );

    if (confirm == true) {
      if (!mounted) return;

      try {
        final provider = Provider.of<AppProvider>(context, listen: false);
        await provider.deleteAccount();

        if (!mounted) return;

        Navigator.of(context).pushNamedAndRemoveUntil(
          '/login',
          (route) => false,
        );
      } catch (e) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: KidTheme.errorRed,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profile),
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
          final user = provider.userProfile;

          if (user == null) {
            return Center(
              child: Text(l10n.noUserDataAvailable),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // Profile Header
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [KidTheme.primaryBlue, KidTheme.primaryBlue.withOpacity(0.7)],
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Column(
                    children: [
                      // Avatar
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Center(
                          child: user.photoUrl != null
                              ? ClipOval(
                                  child: Image.network(
                                    user.photoUrl!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Icon(
                                      Icons.person,
                                      size: 50,
                                      color: KidTheme.primaryBlue.withOpacity(0.7),
                                    ),
                                  ),
                                )
                              : Icon(
                                  Icons.person,
                                  size: 50,
                                  color: KidTheme.primaryBlue.withOpacity(0.7),
                                ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Name
                      Text(
                        user.displayName ?? l10n.user,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      
                      // Email
                      Text(
                        user.email,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                // Profile Details
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Account Information Card
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    l10n.accountInformation,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (!_isEditing)
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        setState(() {
                                          _isEditing = true;
                                        });
                                      },
                                    ),
                                ],
                              ),
                              const Divider(),
                              
                              // Display Name
                              if (_isEditing)
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: _nameController,
                                        decoration: InputDecoration(
                                          labelText: l10n.displayNameLabel,
                                          border: const OutlineInputBorder(),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return l10n.pleaseEnterName;
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      
                                      // Gender field
                                      DropdownButtonFormField<Gender>(
                                        value: _selectedGender,
                                        decoration: InputDecoration(
                                          labelText: l10n.gender,
                                          border: const OutlineInputBorder(),
                                        ),
                                        items: Gender.values.map((Gender gender) {
                                          return DropdownMenuItem<Gender>(
                                            value: gender,
                                            child: Text(gender.getLocalizedName(l10n)),
                                          );
                                        }).toList(),
                                        onChanged: (Gender? newValue) {
                                          setState(() {
                                            _selectedGender = newValue;
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null) {
                                            return l10n.pleaseSelectGender;
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: _isSaving ? null : _handleSave,
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: KidTheme.primaryBlue,
                                                foregroundColor: Colors.white,
                                              ),
                                              child: _isSaving
                                                  ? const SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child: CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        valueColor:
                                                            AlwaysStoppedAnimation<Color>(
                                                                Colors.white),
                                                      ),
                                                    )
                                                  : Text(l10n.save),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: OutlinedButton(
                                              onPressed: () {
                                                setState(() {
                                                  _isEditing = false;
                                                  _loadUserData();
                                                });
                                              },
                                              child: Text(l10n.cancel),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              else
                                Column(
                                  children: [
                                    _buildInfoRow(l10n.displayNameLabel, user.displayName ?? l10n.notSet),
                                    const SizedBox(height: 12),
                                    _buildInfoRow(l10n.emailLabel, user.email),
                                    const SizedBox(height: 12),
                                    _buildInfoRow(
                                      l10n.gender,
                                      user.gender?.getLocalizedName(l10n) ?? l10n.notSet,
                                    ),
                                    const SizedBox(height: 12),
                                    _buildInfoRow(
                                      l10n.memberSince,
                                      _formatDate(context, user.createdAt),
                                    ),
                                    if (user.city != null) ...[
                                      const SizedBox(height: 12),
                                      _buildInfoRow(l10n.location, user.city!),
                                    ],
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Actions
                      Card(
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.logout, color: Colors.orange),
                              title: Text(l10n.logout),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: _handleLogout,
                            ),
                            const Divider(height: 1),
                            ListTile(
                              leading: const Icon(Icons.delete_forever, color: Colors.red),
                              title: Text(l10n.deleteAccount, style: const TextStyle(color: Colors.red)),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: _handleDeleteAccount,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
          },
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(BuildContext context, DateTime date) {
    // Use localized date formatting via DateFormatter
    return DateFormatter.formatDateWithPattern(date, 'detailedDateFormat', context);
  }
}

