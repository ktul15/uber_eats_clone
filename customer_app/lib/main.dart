import 'dart:async';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:customer_app/app/app.dart';
import 'package:customer_app/firebase_options.dart';
import 'package:customer_app/shared/constants/api_constants.dart';
import 'package:customer_app/shared/services/fcm_api_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const stripePublishableKey = String.fromEnvironment('STRIPE_PUBLISHABLE_KEY');
  if (stripePublishableKey.isNotEmpty) {
    Stripe.publishableKey = stripePublishableKey;
    Stripe.urlScheme = 'ubereatsclone';
    await Stripe.instance.applySettings();
  }
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Non-blocking: permission dialog shows after app is already rendered
  unawaited(FirebaseMessaging.instance.requestPermission());
  unawaited(
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    ),
  );

  // Single client instance reused for all token refresh events
  const storage = FlutterSecureStorage();
  final refreshClient = FcmApiClient(
    dio: Dio(BaseOptions(baseUrl: ApiConstants.baseUrl)),
    storage: storage,
  );
  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    unawaited(refreshClient.registerToken(newToken));
  });

  runApp(const ProviderScope(child: App()));
}
