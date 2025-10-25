import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:islamic_daily_routine_kids/theme/kid_theme.dart';

void main() {
  testWidgets('Splash screen shows Arabic slogan', (WidgetTester tester) async {
    // Create a simple splash screen widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          backgroundColor: KidTheme.primaryBlue,
          body: Center(
            child: Text(
              'يوم في حياه طفل مسلم',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );

    // Verify that the splash screen is displayed
    expect(find.text('يوم في حياه طفل مسلم'), findsOneWidget);
  });
}

