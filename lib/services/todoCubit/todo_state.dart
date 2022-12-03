part of 'todo_cubit.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}
class changedScreen extends TodoState {}
class createDatabaseState extends TodoState{}
class insertToDatabaseState extends TodoState {}
class getDataFromDatabaseState extends TodoState {}
class deleteDataFromDatabaseState extends TodoState {}
class changedBottomSheetState extends TodoState {}
class loadingIcobState extends TodoState {}
class updateDatabaseState extends TodoState {}

