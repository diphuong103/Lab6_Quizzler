import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    required this.questionNumber,
    required this.questionText,
    required this.questionCount,
    super.key,
  });

  final int questionNumber;
  final int questionCount;
  final String questionText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'QUESTION ${questionNumber + 1}',
              style: const TextStyle(
                color: Color(0xFFC4B5FD),
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
            Text(
              '${questionNumber + 1} / $questionCount',
              style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: (questionNumber + 1) / questionCount,
            minHeight: 6,
            backgroundColor: const Color(0xFF30384A),
            color: const Color(0xFFA78BFA),
          ),
        ),
        const SizedBox(height: 28),
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 260),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: const Color(0xFF1F2937),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'TRUE OR FALSE?',
                style: TextStyle(
                  color: Color(0xFFA78BFA),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                questionText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFF9FAFB),
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
