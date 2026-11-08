import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../core/utils/labels.dart';

class QualityBadge extends StatelessWidget {
  const QualityBadge({super.key, required this.quality, this.compact = false});

  final String quality;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final color = qualityColor(context, quality);
    final label = qualityLabel(quality);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
        vertical: compact ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall
            ?.copyWith(color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}

Color qualityColor(BuildContext context, String quality) {
  final dark = Theme.of(context).brightness == Brightness.dark;
  return switch (quality) {
    QualityFlag.good =>
      dark ? const Color(0xFF7ED6A0) : const Color(0xFF1B7F4A),
    QualityFlag.fair =>
      dark ? const Color(0xFFF5C86B) : const Color(0xFFA96A00),
    _ => dark ? const Color(0xFFFF9B95) : const Color(0xFFB3261E),
  };
}

class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 132,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
