import 'package:demo_chat/counter/provider/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CounterView();
  }
}

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Title')),
      body: const Center(child: CounterText()),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Consumer(
            builder: (BuildContext ctx, WidgetRef ref, _) {
              final counter = ref.read(counterNotifier.notifier);
              return FloatingActionButton(
                key: const Key('counterView_increment_floatingActionButton'),
                onPressed: counter.increment,
                child: const Icon(Icons.add),
              );
            },
          ),
          const SizedBox(height: 8),
          Consumer(
            builder: (BuildContext ctx, WidgetRef ref, _) {
              final counter = ref.read(counterNotifier.notifier);
              return FloatingActionButton(
                key: const Key('counterView_decrement_floatingActionButton'),
                onPressed: counter.decrement,
                child: const Icon(Icons.remove),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CounterText extends HookWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext ctx, WidgetRef ref, _) {
        final count = ref.watch(counterNotifier);
        return Text('$count');
      },
    );
  }
}
