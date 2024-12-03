import 'package:flutter/material.dart';

import '../style/my_text_style.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? isUseLeading;

  final List<Widget>? actions;

  const MyAppBar(
      {super.key, required this.title, this.isUseLeading = true, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: isUseLeading ?? false,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: MyTextStyle.title,
      ),
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      toolbarHeight: kToolbarHeight,
      elevation: 0,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
