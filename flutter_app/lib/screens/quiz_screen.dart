import 'package:flutter/material.dart';

import '../data/question_bank.dart';
import '../widgets/answer_button.dart';
import '../widgets/question_card.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var _questionIndex = 0;
  var _score = 0;
  bool? _selectedAnswer;

  bool get _isFinished => _questionIndex >= questionBank.length;

  void _answerQuestion(bool answer) {
    if (_selectedAnswer != null || _isFinished) return;

    setState(() {
      _selectedAnswer = answer;
      if (answer == questionBank[_questionIndex].answer) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex++;
      _selectedAnswer = null;
    });
  }

  void _restartQuiz() {
    setState(() {
      _questionIndex = 0;
      _score = 0;
      _selectedAnswer = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  const Text(
                    'QUIZZLER',
                    style: TextStyle(
                      color: Color(0xFFA78BFA),
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: SingleChildScrollView(
                      child: _isFinished
                          ? ResultScreen(
                              score: _score,
                              questionCount: questionBank.length,
                              onRestart: _restartQuiz,
                            )
                          : _buildQuestion(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion() {
    final question = questionBank[_questionIndex];
    final isAnswered = _selectedAnswer != null;

    return Column(
      children: [
        QuestionCard(
          questionNumber: _questionIndex,
          questionText: question.text,
          questionCount: questionBank.length,
        ),
        const SizedBox(height: 22),
        AnswerButton(
          label: 'TRUE',
          color: const Color(0xFF16A085),
          onPressed: isAnswered ? null : () => _answerQuestion(true),
        ),
        const SizedBox(height: 14),
        AnswerButton(
          label: 'FALSE',
          color: const Color(0xFFE0565B),
          onPressed: isAnswered ? null : () => _answerQuestion(false),
        ),
        if (isAnswered) ...[
          const SizedBox(height: 16),
          Text(
            _selectedAnswer == question.answer
                ? 'Correct! Nice work.'
                : 'Not quite. The answer is ${question.answer ? 'True' : 'False'}.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFE5E7EB),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton(
              onPressed: _nextQuestion,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF7C5CE0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                _questionIndex == questionBank.length - 1
                    ? 'SEE RESULTS'
                    : 'NEXT QUESTION',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
