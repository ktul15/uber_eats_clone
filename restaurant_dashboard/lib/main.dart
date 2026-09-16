import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:restaurant_dashboard/app/app.dart';
import 'package:restaurant_dashboard/firebase_options.dart';
import 'package:restaurant_dashboard/shared/constants/api_constants.dart';
import 'package:restaurant_dashboard/shared/services/fcm_api_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  unawaited(FirebaseMessaging.instance.requestPermission());
  unawaited(
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    ),
  );

  const storage = FlutterSecureStorage();
  final refreshClient = FcmApiClient(
    dio: Dio(BaseOptions(baseUrl: ApiConstants.baseUrl)),
    storage: storage,
  );
  FirebaseMessaging.instance.onTokenRefresh.listen(
    (token) => unawaited(refreshClient.registerToken(token)),
  );
  runApp(const ProviderScope(child: App()));
}
