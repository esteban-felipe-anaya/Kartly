import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_paths.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../data/models/address.dart';
import '../../../shared/widgets/states.dart';
import '../application/address_controller.dart';

/// Lists the user's saved shipping addresses with edit/delete actions.
class AddressesScreen extends ConsumerWidget {
  const AddressesScreen({super.key});

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    Address address,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete address?'),
        content: Text('Remove "${address.label}" from your saved addresses.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    try {
      await ref.read(addressControllerProvider.notifier).remove(address.id);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('Could not delete address: $e')));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addresses = ref.watch(addressControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Addresses')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(Routes.addressNew),
        icon: const Icon(Icons.add),
        label: const Text('Add address'),
      ),
      body: addresses.when(
        data: (list) {
          if (list.isEmpty) {
            return EmptyState(
              icon: Icons.location_off_outlined,
              title: 'No addresses',
              message: 'Add an address to speed up checkout.',
              action: FilledButton(
                onPressed: () => context.push(Routes.addressNew),
                child: const Text('Add address'),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(Insets.lg),
            itemCount: list.length,
            itemBuilder: (context, i) => _AddressCard(
              address: list[i],
              onEdit: () => context.push(Routes.addressEdit(list[i].id)),
              onDelete: () => _confirmDelete(context, ref, list[i]),
            ),
          );
        },
        loading: () => const _AddressListSkeleton(),
        error: (e, _) => ErrorView(
          message: '$e',
          onRetry: () => ref.invalidate(addressControllerProvider),
        ),
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  const _AddressCard({
    required this.address,
    required this.onEdit,
    required this.onDelete,
  });

  final Address address;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: Insets.md),
      child: Padding(
        padding: const EdgeInsets.all(Insets.lg),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(address.label, style: theme.textTheme.titleMedium),
                      if (address.isDefault) ...[
                        Gaps.hSm,
                        const Chip(
                          label: Text('Default'),
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ],
                  ),
                  Gaps.vSm,
                  Text(address.fullName, style: theme.textTheme.bodyMedium),
                  Text(
                    address.singleLine,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (address.phone != null && address.phone!.isNotEmpty)
                    Text(
                      address.phone!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  tooltip: 'Edit',
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined),
                ),
                IconButton(
                  tooltip: 'Delete',
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AddressListSkeleton extends StatelessWidget {
  const _AddressListSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(Insets.lg),
      itemCount: 4,
      itemBuilder: (_, _) => const Padding(
        padding: EdgeInsets.only(bottom: Insets.md),
        child: ShimmerBox(height: 120, borderRadius: Radii.lgAll),
      ),
    );
  }
}
