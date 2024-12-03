import 'package:flutter/cupertino.dart';

class ItemPopUpMenu extends StatelessWidget {
  const ItemPopUpMenu({super.key, required this.icons, required this.title});

  final IconData icons;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Icon(icons), Text(title)],
    );
  }
}
