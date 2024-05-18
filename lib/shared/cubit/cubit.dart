import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/modules/archived_tasks/archived_tasks.dart';
import 'package:todo/modules/done_tasks/done_tasks.dart';
import 'package:todo/modules/tasks/tasks.dart';
import 'package:todo/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates>
{

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    const TasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];

  List<String> titles = [
    'TASKS',
    'DONE TASKS',
    'ARCHIVED TASKS',
  ];

  void changeIndex(int index)
  {
    currentIndex = index;
    emit(AppChangeBNBState());
  }

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT,notify INTEGER)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error when creating table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDBState());
    });
  }

  Future<void> insertToDatabase({
    required String title,
    required String time,
    required String date,
    required int notify,
  }) async {
    await database.transaction((txn) => txn.rawInsert(
          'INSERT INTO tasks(title,date,time,status,notify) VALUES("$title","$date","$time","new","$notify")'
      ).then((value) {
        print('$value inserted successfully');
        emit(AppInsertDBState());
        getDataFromDatabase(database);
      }).catchError((error) {
      print('error when inserting new record ${error.toString()}');
    }),);

  }

  void getDataFromDatabase(database)
  {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];


    GetDBLoadingState();
    emit(AppGetDBLoadingState());

    database.rawQuery('SELECT * FROM tasks').then((value)
    {
      value.forEach((element){
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        }else {archivedTasks.add(element);}
      });
      emit(AppGetDBState());
    });
  }

  void updateData({
    required String status,
    required int id,
}) async {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      [status, id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDBState());
    });
  }

  void deleteData({
    required int id,
}) async {
    database.rawUpdate(
      'DELETE FROM tasks WHERE id = ?',
      [id]
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDBState());
    });
  }

  bool isBSShown = false;
  IconData fabIcon = Icons.edit;


  void changeBSState({
    required bool isShow,
    required IconData icon,
})
  {
    isBSShown = isShow;
    fabIcon = icon;
    
    emit(AppChangeBSState());
  }

  GetDBLoadingState() {
    return const Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 7,
            backgroundColor: Color(0xFFde2821),
          ),
          SizedBox(
            width: 7,
          ),
          CircleAvatar(
            radius: 7,
            backgroundColor: Color(0xFFde2821),
          ),
          SizedBox(
            width: 7,
          ),
          CircleAvatar(
            radius: 7,
            backgroundColor: Color(0xFFde2821),
          ),
        ],
      ),
    );
  }
}
