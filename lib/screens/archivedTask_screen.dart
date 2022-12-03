import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../componants/custom_buildTaskItem.dart';
import '../services/todoCubit/todo_cubit.dart';

class archivedTaskScreen extends StatelessWidget {
  const archivedTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var tasks = TodoCubit.get(context).archivedTasks;
        return ListView.separated(
            itemBuilder: (context, index) =>
                buildTaskItem(
                  model: tasks[index],
                  status1: 'new', status2: 'done',
                  icon1: Icons.add, icon2: Icons.check_circle,
                  iconColor1: Colors.blue, iconColor2: Colors.green,)
            , separatorBuilder: (context, index) =>
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey,
            )
            , itemCount: tasks.length);
      },
    );
  }
}

