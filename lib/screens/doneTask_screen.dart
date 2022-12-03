import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/todoCubit/todo_cubit.dart';
import '../componants/custom_buildTaskItem.dart';


class doneTaskScreen extends StatelessWidget {
  const doneTaskScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = TodoCubit
            .get(context)
            .doneTasks;
        return ListView.separated(
            itemBuilder: (context, index) =>
                buildTaskItem(
                  model: tasks[index],
                  status1: 'new', status2: 'archive',
                  icon1: Icons.add, icon2: Icons.archive_outlined,
                  iconColor1: Colors.blue, iconColor2: Colors.grey,)
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



