import 'dart:convert';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hope_hub/core/apiService/apiService.dart';
import 'package:hope_hub/core/auto_route/auto_route.dart';
import 'package:hope_hub/core/const/userData.dart';
import 'package:hope_hub/core/navigationService/navigationService.dart';

import '../../feature/notification/presentation/bloc/notification_bloc.dart';

class FirebaseMessagingService {
  FirebaseMessagingService({required this.context});
  final BuildContext context;
  final storage = const FlutterSecureStorage();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  // Канал для Android уведомлений
  final AndroidNotificationChannel _channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  Future<void> initialize() async {
    // Запрос разрешений для iOS
    await _requestPermissions();

    // Инициализация локальных уведомлений
    await _initializeLocalNotifications();

    if (Platform.isIOS) {
      String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      print('APNS Token: $apnsToken');
    }
    // Получение FCM токена
    String? token = await _fcm.getToken();
      print('FCM Token: $token');

    if(token!=null){
      UserData.fcmToken=token;
    }

    // Сохраните token на вашем сервере для отправки push-уведомлений

    // Обработка уведомлений в разных состояниях приложения
    _setupForegroundHandler();
    _setupBackgroundHandler();
    _setupTerminatedHandler();
  }

  Future<void> _requestPermissions() async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Разрешения на уведомления получены');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('Получены временные разрешения');
    } else {
      print('Разрешения на уведомления отклонены');
    }
  }

  Future<void> _initializeLocalNotifications() async {
    // Инициализация для Android
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@drawable/ic_stat_icon');

    // Инициализация для iOS
    const DarwinInitializationSettings iOSSettings =
    DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    // Общая инициализация
    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    // Создаем канал для Android
    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  void _setupForegroundHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('this is foreground handler');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // Показываем уведомление только если оно есть и приложение в foreground
      if (notification != null && android != null) {
        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _channel.id,
              _channel.name,
              channelDescription: _channel.description,
              icon: '@drawable/ic_stat_icon'
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          payload: json.encode(message.data),
        );
        _updateNotifications();
      }
    });
  }

  void _setupBackgroundHandler() {
    FirebaseMessaging.onMessageOpenedApp.listen((message){
      const androidNotificationDetails = AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        icon: '@drawable/ic_stat_icon', // Имя иконки без расширения
        importance: Importance.max,
        priority: Priority.high,
      );
      print('this is background handler');
      _handleMessage(message);
      _updateNotifications();
    });
  }

  void _updateNotifications() {
    try {
      // Получаем текущий контекст через AutoRouter
      final context = NavigationService.router.navigatorKey.currentContext;
      if (context != null && context.mounted) {
        context.read<NotificationBloc>().add(const GetNotificationRemoteEvent());
      }
    } catch (e) {
      debugPrint('Error updating notifications: $e');
    }
  }

  Future<void> _setupTerminatedHandler() async {
    RemoteMessage? initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
  }

  void _handleMessage(RemoteMessage message) async{
    // Здесь обрабатываем нажатие на уведомление
    _updateNotifications();
    String? token=await storage.read(key: 'token');
    String? userId=await storage.read(key: 'userId');
    if(token!=null){
      UserData.token=token;
      UserData.userId=userId!;
      await NavigationService.router.replaceAll([ NotificationRoute()]);
        // await NavigationService.router.push(const NotificationRoute());

    }else{
      NavigationService.router.push(SignInRoute());
    }
    if (message.data.containsKey('route')) {
      // Навигация к нужному экрану
      final String route = message.data['route'];

      // Используйте ваш навигатор для перехода на нужный экран
      // Navigator.pushNamed(context, route);
    }
  }

  void _onNotificationTap(NotificationResponse response) async{
    if (response.payload != null) {
      final Map<String, dynamic> data = json.decode(response.payload!);
      context.read<NotificationBloc>().add(const GetNotificationEvent());
      // Обработка нажатия на локальное уведомление
        // Если да, просто переключаем вкладку
        // await NavigationService.router.push(const NotificationRoute());
        await NavigationService.router.replaceAll([NotificationRoute()]);



      if (data.containsKey('route')) {
        final String route = data['route'];
        // Навигация
      }
    }
  }
}