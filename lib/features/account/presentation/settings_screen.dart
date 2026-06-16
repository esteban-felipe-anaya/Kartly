import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/design_tokens.dart';
import '../application/settings_controller.dart';

/// App preferences: appearance, language, and about.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  String _localeLabel(Locale? locale) {
    if (locale == null) return 'System';
    return switch (locale.languageCode) {
      'en' => 'English',
      'es' => 'Español',
      _ => locale.languageCode,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeModeControllerProvider);
    final locale = ref.watch(localeControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: ListView(
            padding: const EdgeInsets.all(Insets.lg),
            children: [
              _SectionLabel('Appearance'),
              Gaps.vSm,
              SegmentedButton<ThemeMode>(
                segments: const [
                  ButtonSegment(
                    value: ThemeMode.system,
                    label: Text('System'),
                    icon: Icon(Icons.brightness_auto_outlined),
                  ),
                  ButtonSegment(
                    value: ThemeMode.light,
                    label: Text('Light'),
                    icon: Icon(Icons.light_mode_outlined),
                  ),
                  ButtonSegment(
                    value: ThemeMode.dark,
                    label: Text('Dark'),
                    icon: Icon(Icons.dark_mode_outlined),
                  ),
                ],
                selected: {themeMode},
                onSelectionChanged: (selection) => ref
                    .read(themeModeControllerProvider.notifier)
                    .set(selection.first),
              ),
              Gaps.vXl,
              _SectionLabel('Language'),
              Gaps.vSm,
              DropdownMenu<Locale?>(
                initialSelection: locale,
                expandedInsets: EdgeInsets.zero,
                label: const Text('Language'),
                onSelected: (value) =>
                    ref.read(localeControllerProvider.notifier).set(value),
                dropdownMenuEntries: [
                  DropdownMenuEntry(value: null, label: _localeLabel(null)),
                  for (final supported in supportedLocales)
                    DropdownMenuEntry(
                      value: supported,
                      label: _localeLabel(supported),
                    ),
                ],
              ),
              Gaps.vXl,
              _SectionLabel('About'),
              Gaps.vSm,
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.info_outline),
                title: const Text('Version'),
                trailing: Text(
                  'Kartly 1.0.0',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: theme.textTheme.titleMedium?.copyWith(
        color: theme.colorScheme.primary,
      ),
    );
  }
}
