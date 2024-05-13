import 'package:demo_chat/app/go_router.dart';
import 'package:demo_chat/chat.dart';
import 'package:demo_chat/users/provider/users_provider.dart';
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
          context.goNamed(Routes.login.name);
          await FirebaseAuth.instance.signOut();
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
                    final navigator = Navigator.of(context);
                    final room = await FirebaseChatCore.instance
                        .createRoom(users[index]);
                    await navigator.push(
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          room: room,
                        ),
                      ),
                    );
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
