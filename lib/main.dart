import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo/layout/home_layout.dart';
import 'package:todo/shared/bloc_observer.dart';


void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
      theme: ThemeData(
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

