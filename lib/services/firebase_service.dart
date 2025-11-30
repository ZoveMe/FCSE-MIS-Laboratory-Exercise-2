import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Background notification: ${message.notification?.title}");
}

class FirebaseService {
  static Future<void> init() async {
    await Firebase.initializeApp();


    FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);


    await FirebaseMessaging.instance.requestPermission();


    FirebaseMessaging.instance.subscribeToTopic("daily_recipe");

    print("Firebase initialized & subscribed to daily_recipe");
  }
}
