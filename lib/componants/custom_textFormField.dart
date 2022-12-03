import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class customTextFormField extends StatelessWidget {
  String validate_text = '';
  String label_text = '';
  IconData icon ;
  VoidCallback ontap ;
  TextInputType  text_type;
   customTextFormField({
    Key? key,
    required this.controller,
     required this.validate_text,
     required this.label_text,
     required this.icon ,
     required this.ontap,
     required this.text_type,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: ontap,
      keyboardType: text_type,
      controller: controller,
      validator: (String ? value) {
        if (value!.isEmpty) {
          // return 'Title must be entered';
          return validate_text ;
        }
        return null;
      },
      decoration:  InputDecoration(
        //task title
        label: Text(label_text),
        //icon title
        prefixIcon: Icon(icon),

      ),

    );
  }
}