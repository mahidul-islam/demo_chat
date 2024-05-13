import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

final roomProvider = StateProvider<types.Room?>((ref) => null);
