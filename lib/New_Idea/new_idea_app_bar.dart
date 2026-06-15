import 'package:flutter/material.dart';

class NIAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NIAppBar({super.key, required this.continueClick});
  final VoidCallback continueClick;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title:const Text(
              "New Idea",
              style: TextStyle(fontSize: 20)
            ),
        titleSpacing: 5,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: TextButton(
              onPressed: continueClick, 
              child: const Text("Continue")
            ),
          )],
        );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}