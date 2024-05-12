import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() => state++;
  void decrement() => state--;
}

final counterNotifier = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});
