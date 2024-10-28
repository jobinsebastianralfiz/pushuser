import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationService {

  static NotificationService?_instance;
  static const String ONE_SIGNAL_APP_ID =
      "add yours";

  NotificationService._();


  factory NotificationService(){
    _instance ??= NotificationService._();
    return _instance!;
  }


  Future<void> initialize() async {
    try {
      OneSignal.initialize(ONE_SIGNAL_APP_ID);
      await _requestPermission();
      _setupHandlers();
    } catch (e) {
      debugPrint('Error initializing notifications: $e');
    }
  }

  void _setupHandlers() {
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      debugPrint("Received notification: ${event.notification.title}");
      event.preventDefault();
    });

    OneSignal.Notifications.addClickListener((event) {
      debugPrint("Clicked notification: ${event.notification.title}");
      _handleNotificationClick(event.notification);
    });
  }

  void _handleNotificationClick(OSNotification notification) {
    if (notification.additionalData != null) {
      final data = notification.additionalData!;
      if (data.containsKey('offer_id')) {
        // Here you would typically use GetX, Provider, or your preferred
        // state management solution to handle navigation
        debugPrint('Should navigate to offer: ${data['offer_id']}');
      }
    }
  }

  Future<void> _requestPermission() async {
    try {
      await OneSignal.Notifications.requestPermission(true);


    } catch (e) {
      debugPrint('Error requesting permission: $e');
    }
  }


  Future<bool> isNotificationsEnabled() async {
    try {
      return await OneSignal.Notifications.permission;
    } catch (e) {
      debugPrint('Error checking notification permission: $e');
      return false;
    }
  }
}