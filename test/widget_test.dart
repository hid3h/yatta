import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yatta/ui/home/home_page.dart';

void main() {
  testWidgets('add and toggle task completion', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: HomePage())),
    );

    // Verify app bar title exists
    expect(find.text('タスクリスト'), findsOneWidget);
    expect(find.text('タスクを追加してみましょう！'), findsOneWidget);

    // Add new task
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Enter task name
    await tester.enterText(find.byType(TextField), '筋トレ');
    await tester.tap(find.text('追加'));
    await tester.pump();

    // Verify task was added
    expect(find.text('筋トレ'), findsOneWidget);
    expect(find.byIcon(Icons.radio_button_unchecked), findsOneWidget);

    // Toggle task completion
    await tester.tap(find.text('筋トレ'));
    await tester.pump();

    // Verify task is now completed
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
    expect(find.byIcon(Icons.radio_button_unchecked), findsNothing);
  });
}
