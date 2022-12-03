import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/todoCubit/todo_cubit.dart';

class buildTaskItem extends StatelessWidget {
  Map ? model;
  String ?x;
  String status1 ;
  String status2 ;
  IconData icon1;
  IconData icon2;
  Color iconColor1 ;
  Color iconColor2 ;
  buildTaskItem({super.key,
      required this.model, required this.status1 , required this.status2,
      required this.icon1 , required this.icon2,
      required this.iconColor1, required this.iconColor2});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: Colors.red,
        child: const ListTile(
          title: Text('Swipe to delete', style: TextStyle(fontSize: 20, color: Colors.white),),
        ),
      ) ,
      key: Key(model!['id'].toString()),
      child: Container(
        margin: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              CircleAvatar(
                radius: 40,
                child: Text(
                    '${model!['time']}'
                ),
              ),
              const SizedBox(width: 20,),
              Column(
                mainAxisSize: MainAxisSize.min,
                children:
                [
                  Text('${model!['title']}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  Text('${model!['date']}',
                    style: const TextStyle(color: Colors.grey),),
                ],
              ),
            ],),

            Row(
              children: [
                IconButton(onPressed:
                    (){
                  TodoCubit.get(context).updateData(status: status1, id: model!['id']);
                },
                    icon:  Icon( icon1 , color: iconColor1)),
                IconButton(onPressed:
                    (){
                  TodoCubit.get(context).updateData(status: status2, id: model!['id']);

                }, icon:  Icon( icon2, color: iconColor2,)),
              ],
            ),

          ],
        ),
      ),
      onDismissed: (direction){
        TodoCubit.get(context).deleteData(id: model!['id']);
      },
    );
  }
}
 // status 1 done
 // status 2 archived
// icon1 Icons.check_circle
// icon2 Icons.archive_outlined
// iconcolor 1 green