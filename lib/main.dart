import 'dart:developer';
import 'package:demo_chat/app/app.dart';
import 'package:demo_chat/app/app_provider_observer.dart';
import 'package:demo_chat/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  await Firebase.initializeApp(
    name: '[DEFAULT]',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      observers: [ProviderLogger()],
      child: const App(),
    ),
  );
}
