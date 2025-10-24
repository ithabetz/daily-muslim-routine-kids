import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:islamic_daily_routine_kids/main.dart';

void main() {
  testWidgets('App launches and shows splash screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the splash screen is displayed
    expect(find.text('الروتين الإسلامي اليومي - للأطفال'), findsOneWidget);
    expect(find.byIcon(Icons.mosque), findsOneWidget);
  });
}

