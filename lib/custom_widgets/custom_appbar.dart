import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  List<Widget>? action;

  Color? color;
  CustomAppBar({super.key, this.color, this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      bottomOpacity: 0,
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: color ?? Colors.indigo[50],
      leading: Navigator.canPop(context)
          ? IconButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {}
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.deepPurple,
              ))
          : Container(),
      title: Text(
        title ?? "",
        style: const TextStyle(color: Colors.deepPurple, fontSize: 18),
      ),
      actions: action,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(65);
}
