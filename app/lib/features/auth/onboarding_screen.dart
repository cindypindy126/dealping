import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class _Slide {
  final IconData icon;
  final String title;
  final String subtitle;
  const _Slide(
      {required this.icon, required this.title, required this.subtitle});
}

const _slides = [
  _Slide(
    icon: Icons.credit_card,
    title: '내가 가진 카드로\n최적 혜택을',
    subtitle: '카드 여러 장, 이제 외울 필요 없어요',
  ),
  _Slide(
    icon: Icons.search,
    title: '가맹점을 검색하면',
    subtitle: '내 카드 중 가장 혜택이 좋은 카드를 알려드려요',
  ),
  _Slide(
    icon: Icons.credit_card_off_outlined,
    title: '카드 정보 입력 NO!',
    subtitle: '이름만 검색해서 내 카드로 등록하세요',
  ),
  _Slide(
    icon: Icons.auto_awesome,
    title: '지금 바로 시작하세요',
    subtitle: '카드를 등록하고 혜택을 확인해보세요',
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);
    if (mounted) context.go('/home');
  }

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _controller.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      _finish();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _finish,
                child: Text('건너뛰기',
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: AppColors.textSecondary)),
              ),
            ),
            // Slides
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _slides.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (context, i) {
                  final slide = _slides[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withAlpha(25),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(slide.icon,
                              size: 56, color: AppColors.primary),
                        ),
                        const SizedBox(height: 40),
                        Text(slide.title,
                            style: AppTextStyles.headlineLarge,
                            textAlign: TextAlign.center),
                        const SizedBox(height: 16),
                        Text(slide.subtitle,
                            style: AppTextStyles.bodyLarge
                                .copyWith(color: AppColors.textSecondary),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Dot indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_slides.length, (i) {
                final active = i == _currentPage;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: active ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: active ? AppColors.primary : AppColors.border,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
            const SizedBox(height: 32),
            // Next / Start button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    _currentPage == _slides.length - 1 ? '시작하기' : '다음',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
