import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/components/components.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state){},
      builder: (context, state){
        var tasks = AppCubit.get(context).doneTasks;
        return ConditionalBuilder(
          condition: tasks.isNotEmpty,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildDoneTaskItem(tasks[index], context),
            separatorBuilder: (context,index) => Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20.0,),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[600],
              ),
            ),
            itemCount: tasks.length,
          ),
          fallback: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.menu,
                  size: 100.0,
                  color: Colors.grey[850],
                ),
                Text(
                  'There are no tasks completed yet',
                  style: TextStyle(
                    color: Colors.grey[850],
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
