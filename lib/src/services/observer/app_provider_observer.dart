import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProviderLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log('[${provider.name ?? provider.runtimeType}] value: $previousValue');
    super.didUpdateProvider(provider, previousValue, newValue, container);
  }
}
