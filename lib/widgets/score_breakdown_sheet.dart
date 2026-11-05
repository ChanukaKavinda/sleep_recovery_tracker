import 'package:flutter/material.dart';

import '../logic/scoring.dart';
import '../theme/clay_theme.dart';
import 'clay.dart';

/// Bottom sheet that explains how last night's scores were worked out.
Future<void> showScoreBreakdown(BuildContext context, NightScores scores) {
  final c = context.clay;
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: c.background,
    builder: (context) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, controller) => _BreakdownBody(
        scores: scores,
        controller: controller,
      ),
    ),
  );
}

class _BreakdownBody extends StatelessWidget {
  const _BreakdownBody({required this.scores, required this.controller});

  final NightScores scores;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    final recovery = scores.recoveryPercent;
    return ListView(
      controller: controller,
      padding: const EdgeInsets.fromLTRB(22, 0, 22, 32),
      children: [
        _Headline(
          title: 'Sleep score',
          value: '${scores.sleepScore}',
          label: scoreLabel(scores.sleepScore),
        ),
        const SizedBox(height: 14),
        for (final part in scores.sleepParts) ...[
          _PartRow(part: part, totalWeight: _total(scores.sleepParts)),
          const SizedBox(height: 12),
        ],
        const SizedBox(height: 18),
        _Headline(
          title: 'Recovery',
          value: recovery == null ? '—' : '$recovery%',
          label: recovery == null ? 'Needs more data' : scoreLabel(recovery),
        ),
        const SizedBox(height: 14),
        if (recovery == null)
          Text(
            'Recovery needs one more thing besides your sleep: tap how you '
            'feel on the home screen, or add resting heart rate / HRV.',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              height: 1.4,
              color: c.textMuted,
            ),
          )
        else
          for (final part in scores.recoveryParts) ...[
            _PartRow(part: part, totalWeight: _total(scores.recoveryParts)),
            const SizedBox(height: 12),
          ],
        const SizedBox(height: 20),
        Text(
          'Parts that have no data (like sleep stages without a watch) are '
          'left out and the others count a bit more. Heart rate and HRV '
          'are compared with your own average from the last two weeks.\n\n'
          'This is a wellness estimate to help you build better habits, '
          'not medical advice.',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            height: 1.45,
            color: c.textMuted,
          ),
        ),
      ],
    );
  }

  double _total(List<ScorePart> parts) =>
      parts.fold<double>(0, (sum, p) => sum + p.weight);
}

class _Headline extends StatelessWidget {
  const _Headline({
    required this.title,
    required this.value,
    required this.label,
  });

  final String title;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: c.accent,
            height: 1,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: c.textMuted,
          ),
        ),
      ],
    );
  }
}

class _PartRow extends StatelessWidget {
  const _PartRow({required this.part, required this.totalWeight});

  final ScorePart part;
  final double totalWeight;

  @override
  Widget build(BuildContext context) {
    final c = context.clay;
    final share = totalWeight <= 0 ? 0 : part.weight / totalWeight * 100;
    final color = part.score >= 80
        ? c.remSleep
        : (part.score >= 55 ? c.accent : c.vitals);
    return ClayCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  part.label,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                '${part.score.round()}/100',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${part.detail} · counts ${share.round()}%',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: c.textMuted,
            ),
          ),
          const SizedBox(height: 10),
          ClayProgressBar(value: part.score / 100, color: color, height: 6),
        ],
      ),
    );
  }
}
