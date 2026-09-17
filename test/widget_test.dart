import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fares_portfolio/main.dart';
import 'package:fares_portfolio/theme/app_theme.dart';

void main() {
  testWidgets('Portfolio renders on desktop without overflow', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    // Disable animations so no pending timers are left after dispose.
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(disableAnimations: true),
        child: const PortfolioApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Fares Elhabashy'), findsWidgets);
    expect(find.text('Junior Flutter Developer'), findsOneWidget);
    expect(find.text('Selected projects'), findsOneWidget);
    expect(find.text('Education'), findsWidgets);
    expect(find.text("Let's talk about Flutter."), findsOneWidget);
    expect(find.text('Download CV 📄'), findsOneWidget);
  });

  testWidgets('Portfolio renders on mobile without overflow', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(disableAnimations: true),
        child: const PortfolioApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Fares Elhabashy'), findsWidgets);
    expect(find.text('Junior Flutter Developer'), findsOneWidget);
  });

  testWidgets('Theme toggle switches between Dark and Light mode', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
      themeNotifier.value = ThemeMode.dark;
    });

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(disableAnimations: true),
        child: const PortfolioApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(themeNotifier.value, ThemeMode.dark);

    // Find and tap the theme toggle
    final toggleFinder = find.byTooltip('Switch to Light Mode ☀️');
    expect(toggleFinder, findsOneWidget);
    await tester.tap(toggleFinder);
    await tester.pumpAndSettle();

    expect(themeNotifier.value, ThemeMode.light);

    // Tap again to switch back to dark mode
    final darkToggleFinder = find.byTooltip('Switch to Dark Mode 🌙');
    expect(darkToggleFinder, findsOneWidget);
    await tester.tap(darkToggleFinder);
    await tester.pumpAndSettle();

    expect(themeNotifier.value, ThemeMode.dark);
  });

  test('CV PDF asset exists and is loadable with correct content', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final data = await rootBundle.load('assets/cv/Fares_Elhabashy_CV.pdf');
    expect(data.lengthInBytes, equals(167455));
  });
}
