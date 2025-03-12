import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hope_hub/firebase_options.dart';

import 'my_app_material.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Получено фоновое сообщение: ${message.messageId}');
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );


  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  runApp(MyApp());
}


