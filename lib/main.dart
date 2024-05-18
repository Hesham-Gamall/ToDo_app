import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo/layout/home_layout.dart';
import 'package:todo/shared/bloc_observer.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await AwesomeNotifications().initialize(
    'resource://drawable/icon', [
    NotificationChannel(
      channelGroupKey:'high_importance_channel_group',
      channelKey: 'high_importance_channel',
      channelName: 'Basic notifications',
      channelDescription: 'Notification channel for basic tests',
      defaultColor: const Color(0xFFde2821),
      ledColor: Colors.white,
      importance: NotificationImportance.Max,
      channelShowBadge: true,
      onlyAlertOnce: true,
      playSound: true,
      criticalAlerts: true,
      enableVibration: true,
      defaultRingtoneType: DefaultRingtoneType.Notification,
    ),
    NotificationChannel(
      channelGroupKey:'high_importance_channel_group',
      channelKey: 'schedule',
      channelName: 'schedule notifications',
      channelDescription: 'Notification channel for basic tests',
      defaultColor: const Color(0xFFde2821),
      ledColor: Colors.white,
      importance: NotificationImportance.Max,
      channelShowBadge: true,
      onlyAlertOnce: true,
      playSound: true,
      criticalAlerts: true,
      enableVibration: true,
      soundSource: 'resource://raw/reminder',
    ),
  ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'high_importance_channel_group',
        channelGroupName: 'Group 1',
      ),
    ],
    debug: true,
  );
  bool isAllowedToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();
  if (isAllowedToSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeLayout(),
      theme: ThemeData(
        fontFamily: 'Jaro',
        colorScheme: ThemeData().colorScheme.copyWith(primary: const Color(0xFFde2821),),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFde2821),
          selectionColor: Color(0xFFde2821),
          selectionHandleColor: Color(0xFFde2821),
        ),
        datePickerTheme: ThemeData().datePickerTheme.copyWith(backgroundColor: Colors.white,),
        timePickerTheme: ThemeData().timePickerTheme.copyWith(
          backgroundColor: Colors.white,
          dayPeriodColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.selected) ? const Color(0xFFde2821) : Colors.grey.withOpacity(0.2)),
          dayPeriodTextColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.selected) ? Colors.white : Colors.black),
          dayPeriodBorderSide: const BorderSide(color: Color(0xFFde2821),width: 2),
          dialBackgroundColor: Colors.grey.withOpacity(0.2),
          entryModeIconColor: const Color(0xFFde2821),
          hourMinuteColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.selected) ? const Color(0xFFde2821) : Colors.grey.withOpacity(0.2)),
          hourMinuteTextColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.selected) ? Colors.white : Colors.black),



        )

      ),
    );
  }
}

