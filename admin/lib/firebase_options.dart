import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCKVESUsfifxOzOgcTXw9CZ5-ODGAr8Zjg',
    authDomain: 'dealping-71c69.firebaseapp.com',
    projectId: 'dealping-71c69',
    storageBucket: 'dealping-71c69.firebasestorage.app',
    messagingSenderId: '417461233470',
    appId: '1:417461233470:web:f746b183441e0e9c3d2e6f',
  );
}
