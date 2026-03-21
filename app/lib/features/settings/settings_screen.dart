import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('설정',
            style:
                AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.w700)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          const _SettingsDivider(label: '앱 정보'),
          ListTile(
            leading: const Icon(Icons.info_outline, color: AppColors.primary),
            title: const Text('앱 버전'),
            trailing: Text('1.0.0',
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textSecondary)),
          ),
          const Divider(indent: 16, endIndent: 16),
          const _SettingsDivider(label: '지원'),
          ListTile(
            leading:
                const Icon(Icons.mail_outline, color: AppColors.primary),
            title: const Text('문의하기'),
            trailing: const Icon(Icons.chevron_right,
                color: AppColors.textSecondary),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('준비 중입니다.')),
              );
            },
          ),
          const Divider(indent: 16, endIndent: 16),
          ListTile(
            leading: const Icon(Icons.shield_outlined, color: AppColors.primary),
            title: const Text('개인정보처리방침'),
            trailing: const Icon(Icons.chevron_right,
                color: AppColors.textSecondary),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('준비 중입니다.')),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SettingsDivider extends StatelessWidget {
  final String label;
  const _SettingsDivider({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(label,
          style: AppTextStyles.labelMedium
              .copyWith(color: AppColors.textSecondary)),
    );
  }
}
