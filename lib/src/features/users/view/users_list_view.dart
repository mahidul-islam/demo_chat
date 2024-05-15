import 'package:demo_chat/src/routing/go_router.dart';
import 'package:demo_chat/src/features/chat_room/provider/chat_room_provider.dart';
import 'package:demo_chat/src/features/users/provider/users_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class UserListScreen extends HookConsumerWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersStream = ref.watch(usersStreamProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FirebaseAuth.instance.signOut().then(
                (value) => context.pushReplacementNamed(Routes.login.name),
              );
        },
        child: const Icon(Icons.logout),
      ),
      appBar: AppBar(
        title: const Text('Users List'),
      ),
      body: usersStream.when(
        data: (List<types.User> users) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: const BoxDecoration(color: Colors.blueAccent),
                width: double.infinity,
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: MaterialButton(
                  padding: const EdgeInsets.all(20),
                  onPressed: () async {
                    await FirebaseChatCore.instance
                        .createRoom(users[index])
                        .then((types.Room room) {
                      ref.read(roomProvider.notifier).state = room;
                      context.goNamed(Routes.room.name);
                    });
                  },
                  child: Text(
                    users[index].firstName ?? '--',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              );
            },
            itemCount: users.length,
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text(e.toString())),
      ),
    );
  }
}
