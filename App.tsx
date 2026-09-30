import { StatusBar } from 'expo-status-bar';
import { useState } from 'react';
import { Pressable, StyleSheet, Text, View } from 'react-native';

const QUESTIONS = [
  { text: 'The Pacific Ocean is larger than the Atlantic Ocean.', answer: true },
  { text: 'Lightning never strikes the same place twice.', answer: false },
  { text: 'A group of flamingos is called a flamboyance.', answer: true },
  { text: 'Humans have five lungs.', answer: false },
  { text: 'Honey can remain edible for thousands of years.', answer: true },
  { text: 'The sun is a planet.', answer: false },
] as const;

export default function App() {
  const [questionIndex, setQuestionIndex] = useState(0);
  const [score, setScore] = useState(0);
  const [selectedAnswer, setSelectedAnswer] = useState<boolean | null>(null);
  const isFinished = questionIndex === QUESTIONS.length;
  const question = QUESTIONS[questionIndex];

  function answerQuestion(answer: boolean) {
    if (selectedAnswer !== null || !question) return;
    setSelectedAnswer(answer);
    if (answer === question.answer) setScore((currentScore) => currentScore + 1);
  }

  function continueQuiz() {
    setQuestionIndex((currentIndex) => currentIndex + 1);
    setSelectedAnswer(null);
  }

  function restartQuiz() {
    setQuestionIndex(0);
    setScore(0);
    setSelectedAnswer(null);
  }

  return (
    <View style={styles.container}>
      <StatusBar style="light" />
      <Text style={styles.brand}>QUIZZLER</Text>

      {isFinished ? (
        <View style={styles.resultCard}>
          <Text style={styles.resultIcon}>🏆</Text>
          <Text style={styles.resultTitle}>Quiz complete!</Text>
          <Text style={styles.resultScore}>
            {score} <Text style={styles.resultOutOf}>/ {QUESTIONS.length}</Text>
          </Text>
          <Text style={styles.resultCaption}>correct answers</Text>
          <Pressable
            accessibilityRole="button"
            onPress={restartQuiz}
            style={({ pressed }) => [styles.nextButton, pressed && styles.pressed]}
          >
            <Text style={styles.nextButtonText}>PLAY AGAIN</Text>
          </Pressable>
        </View>
      ) : (
        <>
          <View style={styles.progressRow}>
            <Text style={styles.progressText}>QUESTION {questionIndex + 1}</Text>
            <Text style={styles.progressText}>SCORE {score}</Text>
          </View>
          <View style={styles.progressTrack}>
            <View
              style={[
                styles.progressFill,
                { width: `${((questionIndex + 1) / QUESTIONS.length) * 100}%` },
              ]}
            />
          </View>

          <View style={styles.questionCard}>
            <Text style={styles.questionLabel}>TRUE OR FALSE?</Text>
            <Text accessibilityLiveRegion="polite" style={styles.questionText}>
              {question?.text}
            </Text>
          </View>

          {selectedAnswer === null ? (
            <View style={styles.answerButtons}>
              <Pressable
                accessibilityRole="button"
                onPress={() => answerQuestion(true)}
                style={({ pressed }) => [
                  styles.answerButton,
                  styles.trueButton,
                  pressed && styles.pressed,
                ]}
              >
                <Text style={styles.answerButtonText}>TRUE</Text>
              </Pressable>
              <Pressable
                accessibilityRole="button"
                onPress={() => answerQuestion(false)}
                style={({ pressed }) => [
                  styles.answerButton,
                  styles.falseButton,
                  pressed && styles.pressed,
                ]}
              >
                <Text style={styles.answerButtonText}>FALSE</Text>
              </Pressable>
            </View>
          ) : (
            <View style={styles.feedback}>
              <Text style={styles.feedbackText}>
                {selectedAnswer === question?.answer
                  ? 'Correct! Nice work.'
                  : `Not quite. The answer is ${question?.answer ? 'True' : 'False'}.`}
              </Text>
              <Pressable
                accessibilityRole="button"
                onPress={continueQuiz}
                style={({ pressed }) => [styles.nextButton, pressed && styles.pressed]}
              >
                <Text style={styles.nextButtonText}>NEXT QUESTION</Text>
              </Pressable>
            </View>
          )}
        </>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    backgroundColor: '#111827',
    paddingHorizontal: 24,
  },
  brand: {
    color: '#a78bfa',
    fontSize: 14,
    fontWeight: '800',
    letterSpacing: 4,
    textAlign: 'center',
    marginBottom: 36,
  },
  progressRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  progressText: {
    color: '#c4b5fd',
    fontSize: 12,
    fontWeight: '700',
    letterSpacing: 1,
  },
  progressTrack: {
    height: 6,
    overflow: 'hidden',
    borderRadius: 3,
    backgroundColor: '#30384a',
    marginTop: 12,
  },
  progressFill: {
    height: '100%',
    backgroundColor: '#a78bfa',
  },
  questionCard: {
    minHeight: 260,
    justifyContent: 'center',
    padding: 28,
    borderRadius: 24,
    backgroundColor: '#1f2937',
    marginTop: 28,
  },
  questionLabel: {
    color: '#a78bfa',
    fontSize: 12,
    fontWeight: '800',
    letterSpacing: 2,
    textAlign: 'center',
    marginBottom: 22,
  },
  questionText: {
    color: '#f9fafb',
    fontSize: 25,
    fontWeight: '600',
    lineHeight: 36,
    textAlign: 'center',
  },
  answerButtons: {
    gap: 14,
    marginTop: 22,
  },
  answerButton: {
    minHeight: 58,
    alignItems: 'center',
    justifyContent: 'center',
    borderRadius: 14,
  },
  trueButton: {
    backgroundColor: '#16a085',
  },
  falseButton: {
    backgroundColor: '#e0565b',
  },
  answerButtonText: {
    color: '#ffffff',
    fontSize: 16,
    fontWeight: '800',
    letterSpacing: 2,
  },
  feedback: {
    alignItems: 'center',
    marginTop: 24,
  },
  feedbackText: {
    color: '#e5e7eb',
    fontSize: 16,
    fontWeight: '600',
    textAlign: 'center',
    marginBottom: 18,
  },
  nextButton: {
    minHeight: 52,
    alignItems: 'center',
    justifyContent: 'center',
    alignSelf: 'stretch',
    borderRadius: 14,
    backgroundColor: '#7c5ce0',
    paddingHorizontal: 20,
  },
  nextButtonText: {
    color: '#ffffff',
    fontSize: 14,
    fontWeight: '800',
    letterSpacing: 1,
  },
  pressed: {
    opacity: 0.8,
    transform: [{ scale: 0.98 }],
  },
  resultCard: {
    alignItems: 'center',
    padding: 28,
    borderRadius: 24,
    backgroundColor: '#1f2937',
  },
  resultIcon: {
    fontSize: 52,
  },
  resultTitle: {
    color: '#ffffff',
    fontSize: 27,
    fontWeight: '800',
    marginTop: 14,
  },
  resultScore: {
    color: '#c4b5fd',
    fontSize: 56,
    fontWeight: '800',
    marginTop: 16,
  },
  resultOutOf: {
    color: '#8b95a7',
    fontSize: 28,
    fontWeight: '500',
  },
  resultCaption: {
    color: '#9ca3af',
    fontSize: 14,
    marginBottom: 26,
  },
});
