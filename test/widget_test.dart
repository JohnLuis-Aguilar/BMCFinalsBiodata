import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:myapp/main.dart';

void main() {
  testWidgets('biodata form shows labeled output after Display Text',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Biodata Form'), findsOneWidget);
    expect(find.text('No text entered yet'), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, 'Juan Dela Cruz');
    await tester.enterText(find.byType(TextField).at(1), '21');

    tester.binding.focusManager.primaryFocus?.unfocus();
    await tester.pump();

    final button = find.widgetWithText(ElevatedButton, 'Display Text');
    await tester.ensureVisible(button);
    await tester.pump();
    await tester.tap(button);
    await tester.pump();

    expect(find.text('Name: Juan Dela Cruz'), findsOneWidget);
    expect(find.text('Age: 21'), findsOneWidget);
    expect(find.text('No text entered yet'), findsNothing);
  });

  testWidgets('fields keep separate values', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField).first, 'Maria Clara');
    await tester.enterText(find.byType(TextField).at(3), 'Manila');

    expect(find.widgetWithText(TextField, 'Maria Clara'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Manila'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Cruz'), findsNothing);
  });
}
