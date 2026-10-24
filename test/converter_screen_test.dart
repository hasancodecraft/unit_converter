import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unit_converter_app/app.dart';

void main() {
  testWidgets('Shows the result and changes category in real time', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Unit Converter'), findsOneWidget);
    expect(find.text('0.025 km'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), '10');
    await tester.pump();
    expect(find.text('0.01 km'), findsOneWidget);

    await tester.tap(find.text('Weight'));
    await tester.pump();
    expect(find.text('0.01 kg'), findsOneWidget);

    await tester.tap(find.text('Temp'));
    await tester.pump();
    expect(find.text('50 °F'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.swap_horiz_rounded));
    await tester.pump();
    expect(find.text('-12.222222 °C'), findsOneWidget);
  });
}
