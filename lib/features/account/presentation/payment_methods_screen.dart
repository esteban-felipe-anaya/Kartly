import 'package:flutter/material.dart';

import '../../../core/theme/design_tokens.dart';
import '../../../shared/widgets/states.dart';

/// In-memory mock of a saved card. There is no backend for payment methods.
class _MockCard {
  const _MockCard({required this.brand, required this.last4, required this.exp});

  final String brand;
  final String last4;
  final String exp;
}

/// Manages a local, mock list of saved payment cards.
class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final List<_MockCard> _cards = [
    const _MockCard(brand: 'Visa', last4: '4242', exp: '08/27'),
    const _MockCard(brand: 'Mastercard', last4: '5454', exp: '11/26'),
  ];

  void _remove(int index) => setState(() => _cards.removeAt(index));

  Future<void> _addCard() async {
    final card = await showModalBottomSheet<_MockCard>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => const _AddCardSheet(),
    );
    if (card == null) return;
    setState(() => _cards.add(card));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment methods')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addCard,
        icon: const Icon(Icons.add),
        label: const Text('Add card'),
      ),
      body: _cards.isEmpty
          ? const EmptyState(
              icon: Icons.credit_card_off_outlined,
              title: 'No payment methods',
              message: 'Add a card to check out faster.',
            )
          : ListView.builder(
              padding: const EdgeInsets.all(Insets.lg),
              itemCount: _cards.length,
              itemBuilder: (context, i) {
                final card = _cards[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: Insets.md),
                  child: ListTile(
                    leading: const Icon(Icons.credit_card),
                    title: Text('${card.brand} •••• ${card.last4}'),
                    subtitle: Text('Expires ${card.exp}'),
                    trailing: IconButton(
                      tooltip: 'Delete',
                      onPressed: () => _remove(i),
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class _AddCardSheet extends StatefulWidget {
  const _AddCardSheet();

  @override
  State<_AddCardSheet> createState() => _AddCardSheetState();
}

class _AddCardSheetState extends State<_AddCardSheet> {
  final _number = TextEditingController();
  final _exp = TextEditingController();
  final _name = TextEditingController();

  @override
  void dispose() {
    _number.dispose();
    _exp.dispose();
    _name.dispose();
    super.dispose();
  }

  void _submit() {
    final digits = _number.text.replaceAll(RegExp(r'\D'), '');
    final last4 = digits.length >= 4
        ? digits.substring(digits.length - 4)
        : '0000';
    final exp = _exp.text.trim().isEmpty ? '01/30' : _exp.text.trim();
    Navigator.of(context).pop(
      _MockCard(brand: 'Card', last4: last4, exp: exp),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: Insets.lg,
        right: Insets.lg,
        top: Insets.lg,
        bottom: MediaQuery.viewInsetsOf(context).bottom + Insets.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Add card', style: theme.textTheme.titleLarge),
          Gaps.vLg,
          TextField(
            controller: _number,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Card number'),
          ),
          Gaps.vMd,
          TextField(
            controller: _exp,
            decoration: const InputDecoration(
              labelText: 'Expiry (MM/YY)',
              hintText: '08/27',
            ),
          ),
          Gaps.vMd,
          TextField(
            controller: _name,
            decoration: const InputDecoration(labelText: 'Name on card'),
          ),
          Gaps.vLg,
          FilledButton(
            onPressed: _submit,
            child: const Text('Save card'),
          ),
        ],
      ),
    );
  }
}
