import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:yatta/main.dart';

void main() {
  testWidgets('add and increment habit', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify app bar title exists
    expect(find.text('習慣リスト'), findsOneWidget);
    expect(find.text('Habit 1'), findsNothing);

    // Add new habit
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('Habit 1'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);

    // Increment habit count
    await tester.tap(find.text('Habit 1'));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
  });
}
