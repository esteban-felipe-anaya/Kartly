import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:kartly/core/providers/core_providers.dart';
import 'package:kartly/core/router/route_paths.dart';
import 'package:kartly/core/theme/design_tokens.dart';

/// Branded splash shown on cold start; routes forward to onboarding (first run)
/// or the home shell after a brief, deliberate pause.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      final onboarded = ref.read(localPrefsProvider).onboarded;
      context.go(onboarded ? Routes.home : Routes.onboarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.shopping_bag_rounded,
              size: 88,
              color: theme.colorScheme.primary,
            ),
            Gaps.vLg,
            Text(
              'Kartly',
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Gaps.vXl,
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
