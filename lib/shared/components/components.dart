import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/shared/cubit/cubit.dart';

Widget buildNewTaskItem(Map model, BuildContext context) {
  AppCubit cubit = AppCubit.get(context);
  var desController = TextEditingController(text: '${model['description']}');
  return InkWell(
    onTap: () {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(10),
            titlePadding: const EdgeInsets.all(10),
            actionsPadding: const EdgeInsets.all(10),

            scrollable: true,
            title: Row(
              children: [
                SizedBox(
                  width: 230,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${model['title']}',maxLines: 1,style: const TextStyle(overflow: TextOverflow.ellipsis,),),
                  ),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      cubit.refreshApp();
                      return Navigator.pop(context);
                    },
                    icon: const Icon(
                      size: 30,
                      Icons.highlight_remove,
                      color: Color(0xFFde2821),
                    )),
              ],
            ),
            content: SizedBox(
              width: 300,
              child: TextFormField(
                scrollPadding: const EdgeInsets.all(5),
                maxLength: 500,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                controller: desController,
                maxLines: 5,
                style: const TextStyle(
                  color: Colors.black,
                ),
                keyboardType: TextInputType.text,
                cursorColor: const Color(0xFFde2821),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xFFde2821), width: 2.0),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            actions: [
              Row(
                children: [
                  MaterialButton(
                    onPressed: () {
                      cubit.deleteData(id: model['id']);
                      AwesomeNotifications().cancel(model['notify']);
                      return Navigator.pop(context);
                    },
                    color: const Color(0xFFde2821),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: const Text('Delete the task',style: TextStyle(color: Colors.white),),
                  ),
                  const Spacer(),
                  MaterialButton(
                    onPressed: () {
                      cubit.updateDescription(
                          id: model['id'],
                          description: desController.text,
                      ).then((value) {
                        showToast(text: 'Updated successfully', state: ToastStates.success);
                      });
                      return cubit.refreshApp();
                    },
                    color: const Color(0xFFde2821),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: const Text('Update description',style: TextStyle(color: Colors.white,),),
                  ),
                ],
              ),
            ],
          );
        },
      ).then((value) => cubit.refreshApp());
    },
    child: Dismissible(
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
              icon: const Icon(
                Icons.check_box_outline_blank,
                color: Color(0xFFde2821),
              ),
            ),
            IconButton(
              onPressed: () {
                cubit.updateData(status: 'archived', id: model['id']);
              },
              icon: const Icon(
                Icons.archive_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        cubit.deleteData(id: model['id']);
        AwesomeNotifications().cancel(model['notify']);
      },
    ),
  );
}

Widget buildDoneTaskItem(Map model, BuildContext context) {
  AppCubit cubit = AppCubit.get(context);
  var desController = TextEditingController(text: '${model['description']}');
  return InkWell(
    onTap: () {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(10),
            titlePadding: const EdgeInsets.all(10),
            actionsPadding: const EdgeInsets.all(10),

            scrollable: true,
            title: Row(
              children: [
                SizedBox(
                  width: 230,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${model['title']}',maxLines: 1,style: const TextStyle(overflow: TextOverflow.ellipsis,),),
                  ),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      cubit.refreshApp();
                      return Navigator.pop(context);
                    },
                    icon: const Icon(
                      size: 30,
                      Icons.highlight_remove,
                      color: Color(0xFFde2821),
                    )),
              ],
            ),
            content: SizedBox(
              width: 300,
              child: TextFormField(
                scrollPadding: const EdgeInsets.all(5),
                maxLength: 500,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                controller: desController,
                maxLines: 5,
                style: const TextStyle(
                  color: Colors.black,
                ),
                keyboardType: TextInputType.text,
                cursorColor: const Color(0xFFde2821),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Color(0xFFde2821), width: 2.0),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            actions: [
              Row(
                children: [
                  MaterialButton(
                    onPressed: () {
                      cubit.deleteData(id: model['id']);
                      AwesomeNotifications().cancel(model['notify']);
                      return Navigator.pop(context);
                    },
                    color: const Color(0xFFde2821),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: const Text('Delete the task',style: TextStyle(color: Colors.white),),
                  ),
                  const Spacer(),
                  MaterialButton(
                    onPressed: () {
                      cubit.updateDescription(
                        id: model['id'],
                        description: desController.text,
                      ).then((value) {
                        showToast(text: 'Updated successfully', state: ToastStates.success);
                      });
                      return cubit.refreshApp();
                    },
                    color: const Color(0xFFde2821),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: const Text('Update description',style: TextStyle(color: Colors.white,),),
                  ),
                ],
              ),
            ],
          );
        },
      ).then((value) => cubit.refreshApp());
    },
    child: Dismissible(
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
              icon: const Icon(
                Icons.check_box,
                color: Color(0xFFde2821),
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        cubit.deleteData(id: model['id']);
        AwesomeNotifications().cancel(model['notify']);
      },
    ),
  );
}

Widget buildArchivedTaskItem(Map model, BuildContext context) {
  AppCubit cubit = AppCubit.get(context);
  var desController = TextEditingController(text: '${model['description']}');
  return InkWell(
    onTap: () {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(10),
            titlePadding: const EdgeInsets.all(10),
            actionsPadding: const EdgeInsets.all(10),

            scrollable: true,
            title: Row(
              children: [
                SizedBox(
                  width: 230,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${model['title']}',maxLines: 1,style: const TextStyle(overflow: TextOverflow.ellipsis,),),
                  ),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      cubit.refreshApp();
                      return Navigator.pop(context);
                    },
                    icon: const Icon(
                      size: 30,
                      Icons.highlight_remove,
                      color: Color(0xFFde2821),
                    )),
              ],
            ),
            content: SizedBox(
              width: 300,
              child: TextFormField(
                scrollPadding: const EdgeInsets.all(5),
                maxLength: 500,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                controller: desController,
                maxLines: 5,
                style: const TextStyle(
                  color: Colors.black,
                ),
                keyboardType: TextInputType.text,
                cursorColor: const Color(0xFFde2821),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Color(0xFFde2821), width: 2.0),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            actions: [
              Row(
                children: [
                  MaterialButton(
                    onPressed: () {
                      cubit.deleteData(id: model['id']);
                      AwesomeNotifications().cancel(model['notify']);
                      return Navigator.pop(context);
                    },
                    color: const Color(0xFFde2821),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: const Text('Delete the task',style: TextStyle(color: Colors.white),),
                  ),
                  const Spacer(),
                  MaterialButton(
                    onPressed: () {
                      cubit.updateDescription(
                        id: model['id'],
                        description: desController.text,
                      ).then((value) {
                        showToast(text: 'Updated successfully', state: ToastStates.success);
                      });
                      return cubit.refreshApp();
                    },
                    color: const Color(0xFFde2821),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: const Text('Update description',style: TextStyle(color: Colors.white,),),
                  ),
                ],
              ),
            ],
          );
        },
      ).then((value) => cubit.refreshApp());
    },
    child: Dismissible(
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
              icon: const Icon(
                Icons.check_box_outline_blank,
                color: Color(0xFFde2821),
              ),
            ),
            IconButton(
              onPressed: () {
                cubit.updateData(status: 'new', id: model['id']);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        cubit.deleteData(id: model['id']);
        AwesomeNotifications().cancel(model['notify']);
      },
    ),
  );
}

void navigatTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void showToast({
  required String text,
  required ToastStates state,
}) => Fluttertoast.showToast(
  msg: text,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: chooseToastClr(state),
  textColor: Colors.white,
  fontSize: 16.0,
);

enum ToastStates {success, error, warning}

Color chooseToastClr(ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.yellow;
      break;
  }
  return color;
}