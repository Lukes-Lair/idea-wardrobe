import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback func;
  const MainAppBar({required this.func});


  @override
  Widget build(BuildContext context) {
    return AppBar(
            title: Text("Idea Organizer"),
            titleTextStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            actions:[
              Padding(
                padding: EdgeInsetsGeometry.directional(end: 15),
                child: TextButton(
                  onPressed: func, 
                  style: TextButton.styleFrom(
                    shape: CircleBorder(),
                    minimumSize: const Size(80,80),
                    padding: EdgeInsets.zero
                ), 
                child: Text("+",style: TextStyle(fontSize: 40))
                )
              )
            ],
            centerTitle: true,
          );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}