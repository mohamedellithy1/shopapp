import 'package:flutter/material.dart';

Widget defaultButton ({
  double width = double.infinity,
  Color background = Colors.blue,
  @required String text ,
  @required Function onTap,
  double textSize ,
  bool isToUpperCase = true,
  double radius = 0.0,})=> Container(
  decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(radius)
  ),
  width: width,
  child: MaterialButton(
    onPressed: onTap,
   child: Text
     (
     isToUpperCase ? text.toUpperCase() : text
     , style:
   TextStyle(color: Colors.white, fontSize: textSize),),),
);
Widget defaultTextForm({
 @required TextEditingController controller ,
  @required TextInputType type ,
 @required String labelText,
  Function onChanged,
  Function onSubmit,
  bool isPassword = false,
  @required Function validated,
  @required IconData prefix,
  IconData suffix,
  Function onPressed,
  Function onTap,
  bool isClickable = true,
}) =>    TextFormField(
  validator: validated,
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  onTap: onTap,
  enabled: isClickable,
  decoration:InputDecoration(
      labelText: labelText,
      suffixIcon: suffix!=null ?IconButton(
          icon: Icon(suffix, color: Colors.black,),
          onPressed: onPressed) : null
      ,prefixIcon: Icon(prefix, color: Colors.black,),
      border: OutlineInputBorder()
  ) ,
);
Widget buildSeparator()=> Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child:   Container(

    width: double.infinity,

    height: 1,

    color: Colors.black,

  ),
);