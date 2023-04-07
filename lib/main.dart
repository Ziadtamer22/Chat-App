import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'modules/chat_screen/views/chat_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: ChatView(),
  ));
}
