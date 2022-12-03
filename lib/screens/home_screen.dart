import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo2/services/todoCubit/todo_cubit.dart';
import '../componants/custom_textFormField.dart';
import 'archivedTask_screen.dart';
import 'doneTask_screen.dart';
import 'newTask_screen.dart';

class MyHomePage extends StatelessWidget {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit()..createDatabase(),
      child: BlocConsumer<TodoCubit, TodoState>(
        listener: (context, state) {
          if (state is insertToDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          TodoCubit cubit = TodoCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);
                    titleController.text = '';
                    timeController.text = '';
                    dateController.text = '';
                  }
                } else {
                  scaffoldKey.currentState?.showBottomSheet((context) =>
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Form(
                          key: formKey,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                customTextFormField(
                                  controller: titleController,
                                  validate_text: 'Task title must be entered',
                                  label_text: 'Task title',
                                  icon: Icons.title,
                                  ontap: () {  },
                                  text_type: TextInputType.text,),
                                const SizedBox(height: 15,),
                                customTextFormField(
                                  controller: timeController,
                                  validate_text: 'Task time must be entered',
                                  label_text: 'Task time',
                                  icon: Icons.timelapse,
                                  ontap: ()
                                  {
                                    showTimePicker(context: context,
                                        initialTime: TimeOfDay.now()).then((
                                        value) {
                                      timeController.text =
                                          value!.format(context).toString();
                                      print(value!.format(context));
                                    });
                                  },
                                  text_type: TextInputType.datetime,),
                                const SizedBox(height: 15,),
                                customTextFormField(
                                  controller: dateController,
                                  validate_text: 'Task date must be entered',
                                  label_text: 'Task date',
                                  icon: Icons.calendar_month,
                                  ontap: ()
                                  {
                                    showDatePicker(context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('2050-12-31'))
                                        .then((value) {
                                      print(DateFormat.yMMMd().format(value!));
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                  text_type: TextInputType.datetime,),
                              ]),
                        ),
                      ),
                      elevation: 20).closed.then((value) {
                        cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);

                  });
                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(cubit.fabIcon, color: Colors.white,),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (int index) {
                cubit.chang_screens(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.task), label: 'Task'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: 'Archived'),
              ],
            ),
            body: ConditionalBuilder(condition: state is! loadingIcobState,
                builder: (context) => cubit.screens[cubit.currentIndex],
                fallback: (context) =>
                    Center(child: CircularProgressIndicator())),
          );
        },
      ),
    );
  }
}


