import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import '../../screens/archivedTask_screen.dart';
import '../../screens/doneTask_screen.dart';
import '../../screens/newTask_screen.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  static TodoCubit get (context) => BlocProvider.of(context);

  Database ? database ;
  List <Map> newTasks = [];
  List <Map> doneTasks = [];
  List <Map> archivedTasks = [];


  IconData fabIcon = Icons.edit ;
  bool isBottomSheetShown = false;


  int currentIndex = 0;
  List <Widget> screens = [
    newTaskScreen(),
    doneTaskScreen(),
    archivedTaskScreen(),
  ];
  List <String> titles = [
    'New Task',
    'Done Task',
    'Archived Task',
  ];

  void chang_screens (int index){
    currentIndex = index ;
    emit(changedScreen());
  }

  void changeBottomSheetState ({required bool isShow, required IconData icon}){
    isBottomSheetShown = isShow ;
    fabIcon = icon ;
    emit(changedBottomSheetState());
  }

  void createDatabase()  {
    openDatabase('todo.db', version: 1,
      onCreate: (database, version) async {
        database.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT, status TEXT)'
        ).then((value) {
          print('table is created');
        }).catchError((error) {
          print('Error while creating table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
      },
    ).then((value) {
      database = value ;
      emit(createDatabaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database!.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time","new")'
      ).then((value) {
        print('$value inserted successfully');
        emit(insertToDatabaseState());

        getDataFromDatabase(database);
      }).catchError((error) {
        print('error when inserting data ${error.toString()}');
      });
    });
  }

  void getDataFromDatabase(database)  {

    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(loadingIcobState());
    database.rawQuery('SELECT * FROM tasks').then((value){
      value.forEach((element) {
        if (element['status'] == 'new'){
          newTasks.add(element);
        }else if (element['status'] == 'done'){
          doneTasks.add(element);
        }else {
          archivedTasks.add(element);
        }
      });
      emit(getDataFromDatabaseState());
    });
  }

  void updateData ({required String status, required int id}) async {
    database!.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?', ['$status', id]
    ).then((value){
      getDataFromDatabase(database);
      emit(updateDatabaseState());
    });

  }

  void deleteData ({required int id}) async {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]
    ).then((value){
      getDataFromDatabase(database);
      emit(deleteDataFromDatabaseState());
    });

  }


}
