import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:maqam_v2/core/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required this.isRoot,
  });

  final String title;
  final bool isRoot;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isRoot
          ? IconButton(
              icon: Icon(
                Icons.menu,
                color: Green,
              ),
              onPressed: () {
                ZoomDrawer.of(context)!.toggle();
              },
            )
          : null,
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style:
            TextStyle(fontSize: 27, color: Green, fontWeight: FontWeight.bold),
      ),
      actions: const [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
