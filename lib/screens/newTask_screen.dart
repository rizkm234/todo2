import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo2/services/todoCubit/todo_cubit.dart';
import '../componants/custom_buildTaskItem.dart';

class newTaskScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var tasks = TodoCubit.get(context).newTasks;
        return ConditionalBuilder(
            condition: tasks.isNotEmpty,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) =>
                    buildTaskItem(
                      model: tasks[index],
                      status1: 'done', status2: 'archive',
                      icon1: Icons.check_circle, icon2: Icons.archive_outlined,
                      iconColor1: Colors.green, iconColor2: Colors.grey,)
                , separatorBuilder: (context, index) =>
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                )
                , itemCount: tasks.length),
            fallback: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.menu , size: 50,color: Colors.grey,),
                  Text('No Tasks' ,
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.grey),)
                ],
              ),
            ));
      },
    );
  }
}

