import 'package:flutter_test/flutter_test.dart';
import 'package:lab6_quizzler/main.dart';

void main() {
  testWidgets('scores answers, shows results, and restarts the quiz', (
    tester,
  ) async {
    await tester.pumpWidget(const QuizzlerApp());

    expect(find.text('QUESTION 1'), findsOneWidget);
    await tester.tap(find.text('TRUE'));
    await tester.pumpAndSettle();
    expect(find.text('Correct! Nice work.'), findsOneWidget);

    await tester.ensureVisible(find.text('NEXT QUESTION'));
    await tester.tap(find.text('NEXT QUESTION'));
    await tester.pumpAndSettle();
    expect(find.text('QUESTION 2'), findsOneWidget);

    for (var question = 1; question < 6; question++) {
      final correctAnswer = question.isOdd ? 'FALSE' : 'TRUE';
      await tester.tap(find.text(correctAnswer));
      await tester.pumpAndSettle();
      final nextButton = question == 5 ? 'SEE RESULTS' : 'NEXT QUESTION';
      await tester.ensureVisible(find.text(nextButton));
      await tester.tap(find.text(nextButton));
      await tester.pumpAndSettle();
    }

    expect(find.text('Quiz complete!'), findsOneWidget);
    expect(find.text('6 / 6'), findsOneWidget);

    await tester.tap(find.text('PLAY AGAIN'));
    await tester.pumpAndSettle();
    expect(find.text('QUESTION 1'), findsOneWidget);
  });
}
