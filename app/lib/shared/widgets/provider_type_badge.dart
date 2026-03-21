import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ProviderTypeBadge extends StatelessWidget {
  final String providerType; // 'card' | 'telecom'
  final String? cardType;    // 'credit' | 'debit' | null

  const ProviderTypeBadge({
    super.key,
    required this.providerType,
    this.cardType,
  });

  @override
  Widget build(BuildContext context) {
    final (label, color) = _resolve();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withAlpha(80)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  (String, Color) _resolve() {
    if (providerType == 'telecom') {
      return ('통신사', AppColors.telecomBadge);
    }
    if (cardType == 'debit') {
      return ('체크카드', AppColors.debitBadge);
    }
    return ('신용카드', AppColors.creditBadge);
  }
}
