import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../l10n/app_localizations.dart';
import '../theme/kid_theme.dart';

/// Base screen component for Islamic app screens that share common structure
/// This provides a consistent layout and common functionality for screens like
/// PrayersScreen, QuranScreen, and other Islamic screens
class BaseIslamicScreen extends StatefulWidget {
  final String title;
  final Widget header;
  final Widget mainContent;
  final Widget sections;
  final VoidCallback? onHistoryPressed;
  final List<Widget>? appBarActions;
  final Future<void> Function()? onRefresh;
  final String? historyTooltip;

  const BaseIslamicScreen({
    super.key,
    required this.title,
    required this.header,
    required this.mainContent,
    required this.sections,
    this.onHistoryPressed,
    this.appBarActions,
    this.onRefresh,
    this.historyTooltip,
  });

  @override
  State<BaseIslamicScreen> createState() => _BaseIslamicScreenState();
}

class _BaseIslamicScreenState extends State<BaseIslamicScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: KidTheme.primaryBlue,
        foregroundColor: Colors.white,
        actions: [
          // History button (if provided)
          if (widget.onHistoryPressed != null)
            IconButton(
              icon: const Icon(Icons.history),
              onPressed: widget.onHistoryPressed,
              tooltip: widget.historyTooltip ?? l10n.historyAndReports,
            ),
          // Additional app bar actions
          ...?widget.appBarActions,
        ],
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: Text(l10n.loading));
          }

          // Check if there's no data based on the screen type
          if (_hasNoData(provider)) {
            return Center(child: Text(l10n.noData));
          }

          return Container(
            color: Colors.white,
            child: RefreshIndicator(
              color: KidTheme.primaryBlue,
              onRefresh: widget.onRefresh ?? () async {},
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header section
                      widget.header,
                      const SizedBox(height: 16),
                      
                      // Main content (usually the rings/cards)
                      widget.mainContent,
                      const SizedBox(height: 24),
                      
                      // Sections
                      widget.sections,
                      
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Determines if the screen should show "no data" message
  /// This is implemented based on the screen type inferred from the title
  bool _hasNoData(AppProvider provider) {
    final title = widget.title.toLowerCase();
    
    if (title.contains('routine') || title.contains('daily')) {
      // Prayers & Azkar screen
      return provider.todayProgress == null;
    }
    
    return false;
  }
}

/// Widget for creating section titles with consistent styling
class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            color: iconColor ?? Colors.green,
            size: 24,
          ),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(width: 8),
          Text(
            subtitle!,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}

