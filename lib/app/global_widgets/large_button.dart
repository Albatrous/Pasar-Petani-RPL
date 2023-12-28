import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const LargeButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return FilledButton(
      style: FilledButton.styleFrom(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          minimumSize: Size(MediaQuery.of(context).size.width, 44 * ffem)),
      // minimumSize: Size(double.infinity, 44 * ffem)),
      onPressed: onPressed,
      child: Text(text, style: Theme.of(context).textTheme.labelLarge),
    );
  }
}
