import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/design_tokens.dart';
import '../../../data/models/address.dart';
import '../application/address_controller.dart';

/// Create or edit a shipping address.
class AddressFormScreen extends ConsumerStatefulWidget {
  const AddressFormScreen({super.key, this.addressId});

  final String? addressId;

  @override
  ConsumerState<AddressFormScreen> createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends ConsumerState<AddressFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _label;
  late final TextEditingController _fullName;
  late final TextEditingController _line1;
  late final TextEditingController _line2;
  late final TextEditingController _city;
  late final TextEditingController _state;
  late final TextEditingController _postalCode;
  late final TextEditingController _country;
  late final TextEditingController _phone;

  bool _isDefault = false;
  bool _saving = false;

  bool get _isEditing => widget.addressId != null;

  @override
  void initState() {
    super.initState();
    Address? existing;
    if (_isEditing) {
      final list = ref.read(addressControllerProvider).valueOrNull ?? const [];
      existing = list.firstWhereOrNull((a) => a.id == widget.addressId);
    }
    _label = TextEditingController(text: existing?.label ?? 'Home');
    _fullName = TextEditingController(text: existing?.fullName ?? '');
    _line1 = TextEditingController(text: existing?.line1 ?? '');
    _line2 = TextEditingController(text: existing?.line2 ?? '');
    _city = TextEditingController(text: existing?.city ?? '');
    _state = TextEditingController(text: existing?.state ?? '');
    _postalCode = TextEditingController(text: existing?.postalCode ?? '');
    _country = TextEditingController(text: existing?.country ?? 'USA');
    _phone = TextEditingController(text: existing?.phone ?? '');
    _isDefault = existing?.isDefault ?? false;
  }

  @override
  void dispose() {
    _label.dispose();
    _fullName.dispose();
    _line1.dispose();
    _line2.dispose();
    _city.dispose();
    _state.dispose();
    _postalCode.dispose();
    _country.dispose();
    _phone.dispose();
    super.dispose();
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required';
    return null;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final body = <String, dynamic>{
      'label': _label.text.trim(),
      'fullName': _fullName.text.trim(),
      'line1': _line1.text.trim(),
      'line2': _line2.text.trim(),
      'city': _city.text.trim(),
      'state': _state.text.trim(),
      'postalCode': _postalCode.text.trim(),
      'country': _country.text.trim(),
      'phone': _phone.text.trim(),
      'isDefault': _isDefault,
    };

    try {
      final notifier = ref.read(addressControllerProvider.notifier);
      if (_isEditing) {
        await notifier.edit(widget.addressId!, body);
      } else {
        await notifier.add(body);
      }
      if (!mounted) return;
      context.pop();
    } catch (e) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('Could not save address: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? 'Edit address' : 'Add address')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(Insets.lg),
              children: [
                TextFormField(
                  controller: _label,
                  decoration: const InputDecoration(labelText: 'Label'),
                  validator: _required,
                ),
                Gaps.vMd,
                TextFormField(
                  controller: _fullName,
                  decoration: const InputDecoration(labelText: 'Full name'),
                  validator: _required,
                ),
                Gaps.vMd,
                TextFormField(
                  controller: _line1,
                  decoration: const InputDecoration(labelText: 'Address line 1'),
                  validator: _required,
                ),
                Gaps.vMd,
                TextFormField(
                  controller: _line2,
                  decoration:
                      const InputDecoration(labelText: 'Address line 2 (optional)'),
                ),
                Gaps.vMd,
                TextFormField(
                  controller: _city,
                  decoration: const InputDecoration(labelText: 'City'),
                  validator: _required,
                ),
                Gaps.vMd,
                TextFormField(
                  controller: _state,
                  decoration: const InputDecoration(labelText: 'State'),
                  validator: _required,
                ),
                Gaps.vMd,
                TextFormField(
                  controller: _postalCode,
                  decoration: const InputDecoration(labelText: 'Postal code'),
                  validator: _required,
                ),
                Gaps.vMd,
                TextFormField(
                  controller: _country,
                  decoration: const InputDecoration(labelText: 'Country'),
                  validator: _required,
                ),
                Gaps.vMd,
                TextFormField(
                  controller: _phone,
                  decoration: const InputDecoration(labelText: 'Phone (optional)'),
                  keyboardType: TextInputType.phone,
                ),
                Gaps.vSm,
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Set as default'),
                  value: _isDefault,
                  onChanged: (v) => setState(() => _isDefault = v),
                ),
                Gaps.vLg,
                FilledButton(
                  onPressed: _saving ? null : _save,
                  child: _saving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
