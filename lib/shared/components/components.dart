import 'package:flutter/material.dart';
import 'package:todo/shared/cubit/cubit.dart';

Widget buildNewTaskItem(Map model, BuildContext context) {
   AppCubit cubit = AppCubit.get(context);
 return Dismissible(
   key: Key(model['id'].toString()),
   child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFde2821),
            radius: 40.0,
            child: Text(
              '${model['time']}',
              maxLines: 1,
              style: const TextStyle(
                color: Colors.white,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['title']}',
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23.0,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${model['date']}',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 15.0,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          IconButton(
            onPressed: () {
              cubit.updateData(status: 'done', id: model['id']);
            },
            icon: const Icon(Icons.check_box_outline_blank,
              color: Color(0xFFde2821),
            ),
          ),
          IconButton(

            onPressed: () {
              cubit.updateData(status: 'archived', id: model['id']);
            },
            icon: const Icon(Icons.archive_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
   onDismissed: (direction)
   {
     cubit.deleteData(id: model['id']);
   },
 );
}
Widget buildDoneTaskItem(Map model, BuildContext context) {
   AppCubit cubit = AppCubit.get(context);
 return Dismissible(
   key: Key(model['id'].toString()),
   child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFde2821),
            radius: 40.0,
            child: Text(
              '${model['time']}',
              maxLines: 1,
              style: const TextStyle(
                color: Colors.white,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['title']}',
                  maxLines: 1,
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Color(0xFFde2821),
                    decorationStyle: TextDecorationStyle.wavy,
                    decorationThickness: 3.0,
                    color: Colors.white,
                    fontSize: 23.0,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${model['date']}',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 15.0,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          IconButton(
            onPressed: () {
                  cubit.updateData(status: 'new', id: model['id']);
            },
            icon: const Icon(Icons.check_box,
              color: Color(0xFFde2821),
            ),
          ),
        ],
      ),
    ),
   onDismissed: (direction)
   {
     cubit.deleteData(id: model['id']);
   },
 );
}
Widget buildArchivedTaskItem(Map model, BuildContext context) {
   AppCubit cubit = AppCubit.get(context);
 return Dismissible(
   key: Key(model['id'].toString()),
   child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFde2821),
            radius: 40.0,
            child: Text(
              '${model['time']}',
              maxLines: 1,
              style: const TextStyle(
                color: Colors.white,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['title']}',
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23.0,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${model['date']}',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 15.0,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          IconButton(
            onPressed: () {
                  cubit.updateData(status: 'done', id: model['id']);
            },
            icon: const Icon(Icons.check_box_outline_blank,
              color: Color(0xFFde2821),
            ),
          ),
          IconButton(
            onPressed: () {
              cubit.updateData(status: 'new', id: model['id']);
            },
            icon: const Icon(Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
   onDismissed: (direction)
   {
     cubit.deleteData(id: model['id']);
   },
 );
}