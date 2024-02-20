import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class pushNotification {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  //request notification permission
  static Future init() async {
    final firebaseMessaging = FirebaseMessaging.instance;
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    //get device fcm token
    final token = await _firebaseMessaging.getToken();
    await FirebaseFirestore.instance.collection("datas").add({"token": token});
    log(token.toString());

    print("device token: $token");
  }
}

class FirebaseNoti {
  Future<void> pushnoti() async {
    final msg = FirebaseMessaging.instance;
    await msg.requestPermission();
    final token = await msg.getToken();
    log(token.toString());
    FirebaseMessaging.onBackgroundMessage(backgroundMsg);
  }
}

Future<void> backgroundMsg(RemoteMessage message) async {
  log("Received Message");
}
