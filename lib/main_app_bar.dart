import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback func;
  const MainAppBar({super.key, required this.func});


  @override
  Widget build(BuildContext context) {
    return AppBar(
            title: const Text("Idea Organizer"),
            titleTextStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            actions:[
              Padding(
                padding: const EdgeInsetsGeometry.directional(end: 15),
                child: TextButton(
                  onPressed: func, 
                  style: TextButton.styleFrom(
                    shape: const CircleBorder(),
                    minimumSize: const Size(80,80),
                    padding: EdgeInsets.zero
                ), 
                child: const Text("+",style: TextStyle(fontSize: 40))
                )
              )
            ],
            centerTitle: true,
          );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}