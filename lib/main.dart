import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'herdgpt_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // In debug mode, use the Firebase emulator
  if (kDebugMode) {
    try {
      FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    } catch (e) {
      debugPrint('Failed to initialize Firebase emulators with exception, $e');
    }
  }

  runApp(const HerdGPTApp());
}
