import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData icon;
  final List<Widget>? actions;
  final bool showActions;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.icon,
    this.actions,
    this.showActions = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0062CA),
            Color(0xFF008FFF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: AppBar(
        title: Row(
          children: [
            Icon(icon, size: 28, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: showActions ? actions : null,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
