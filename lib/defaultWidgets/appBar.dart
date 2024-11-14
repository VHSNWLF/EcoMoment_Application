// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, file_names

import 'package:flutter/material.dart';

class WidgetAppBar extends StatefulWidget implements PreferredSizeWidget{
  String title = "";
  int x = 0;
  int y = 0;
  int z = 0;
  WidgetAppBar(this.title, this.x, this.y, this.z,{super.key});
  WidgetAppBar.n({super.key});

  @override
  State<WidgetAppBar> createState() => _WidgetAppBarState();
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _WidgetAppBarState extends State<WidgetAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.title,
          style: TextStyle(
            color: const Color.fromARGB(255, 46, 46, 46),
            fontSize: 38,
            shadows: [
              Shadow(
                color: Color.fromARGB(255, widget.x, widget.y, widget.z), 
                offset: Offset(1, 1),
              )
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 224, 224, 224),
        
      );
  }
  
}