import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

import '../shared/notification_services.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

  @override
  void initState() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationService.onActionReceivedMethod,
      onNotificationDisplayedMethod: NotificationService.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: NotificationService.onDismissActionReceivedMethod,
      onNotificationCreatedMethod: NotificationService.onNotificationCreatedMethod,
    );
    super.initState();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();

  String? notifyTitle;
  String? notifyTime;
  String? notifyDate;

  int id = 0;

  late DateTime sD;
  late TimeOfDay sT;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDBState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text(
                cubit.titles[cubit.currentIndex],
                style: const TextStyle(
                  color: Color(0xFFde2821),
                ),
              ),
              centerTitle: true,
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDBLoadingState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) =>  cubit.GetDBLoadingState(),
            ),
            floatingActionButton: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: FloatingActionButton(
                highlightElevation: 20,
                backgroundColor: const Color(0xFFde2821),
                child: Icon(
                  cubit.fabIcon,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (cubit.isBSShown) {
                    if (formKey.currentState!.validate()) {
                      notifyTitle = titleController.text;
                      notifyTime = timeController.text;
                      notifyDate = dateController.text;
                      cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text,
                        notify: id,
                      ).then((value) {
                        AwesomeNotifications().createNotification(
                          content: NotificationContent(
                            id: id,
                            channelKey: 'high_importance_channel',
                            title: notifyTitle,
                            largeIcon: 'resource://drawable/icon',
                            body: 'A reminder for this task was created on $notifyDate at $notifyTime.',
                          ),
                        ).then((value) {
                          AwesomeNotifications().createNotification(
                            content: NotificationContent(
                              id: id,
                              channelKey: 'schedule',
                              title: notifyTitle,
                              largeIcon: 'resource://drawable/icon',
                              body: 'It\'s your task time, go and finish it 💪',
                              displayOnBackground: true,
                              displayOnForeground: true,
                              wakeUpScreen: true,
                            ),
                            schedule: NotificationCalendar(year: sD.year,month: sD.month,day: sD.day, hour: sT.hour,minute: sT.minute),
                          );
                          id += 1;
                        });
                      });
                      formKey.currentState?.reset();
                    }
                  } else {
                    scaffoldKey.currentState
                        ?.showBottomSheet(
                          (context) => Container(
                            padding: const EdgeInsets.all(30.0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: const BorderRadiusDirectional.only(topEnd: Radius.circular(20.0),topStart: Radius.circular(20.0),),
                              border: Border.all(color: const Color(0xFFde2821),width: 4),
                            ),
                            child: Form(
                              key: formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      controller: titleController,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'title must not be empty';
                                        }
                                        return null;
                                      },
                                      cursorColor: const Color(0xFFde2821),
                                      decoration: InputDecoration(
                                        labelText: 'TASK TITLE',
                                        prefixIcon: const Icon(
                                          Icons.title,
                                          color: Color(0xFFde2821),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.white,width: 2.0),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      controller: timeController,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      keyboardType: TextInputType.none,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'time must not be empty';
                                        }
                                        return null;
                                      },
                                      onTap: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) {
                                              sT = value!;
                                          timeController.text =
                                              value.format(context).toString();
                                        });
                                      },
                                      cursorColor: const Color(0xFFde2821),
                                      decoration: InputDecoration(
                                        labelText: 'TASK TIME',
                                        prefixIcon: const Icon(
                                          Icons.watch_later_outlined,
                                          color: Color(0xFFde2821),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.white,width: 2.0),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      controller: dateController,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      keyboardType: TextInputType.none,
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.parse('2030-12-31'),
                                        ).then((value) {
                                          sD = value!;
                                          dateController.text =
                                              DateFormat.yMMMd().format(value);
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'date must not be empty';
                                        }
                                        return null;
                                      },
                                      cursorColor: const Color(0xFFde2821),
                                      decoration: InputDecoration(
                                        labelText: 'TASK DATE',
                                        prefixIcon: const Icon(
                                          Icons.calendar_today,
                                          color: Color(0xFFde2821),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.white,width: 2.0),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .closed
                        .then((value) {
                      cubit.changeBSState(isShow: false, icon: Icons.edit);
                      formKey.currentState?.reset();
                    });
                    cubit.changeBSState(isShow: true, icon: Icons.add);
                  }
                },
              ),
            ),
            bottomNavigationBar: Theme(
              data: ThemeData(
                splashFactory: InkRipple.splashFactory,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.black,
                fixedColor: const Color(0xFFde2821),
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.white,
                currentIndex: cubit.currentIndex,
                unselectedLabelStyle: const TextStyle(fontFamily: 'Jaro',fontSize: 15),
                selectedLabelStyle: const TextStyle(fontFamily: 'Jaro',fontSize: 17),
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu_rounded,
                    ),
                    label: 'TASKS',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.task_alt,
                    ),
                    label: 'DONE',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.archive_outlined,
                    ),
                    label: 'ARCHIVE',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
