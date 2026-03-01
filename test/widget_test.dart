import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_portfolio/main.dart';

void main() {
  testWidgets('Portfolio loads successfully test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PortfolioApp());

    // Verify that our main web title title is visible
    expect(find.text('<Daniel />'), findsOneWidget);
  });
}
