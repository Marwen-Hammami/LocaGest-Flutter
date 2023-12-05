import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  //var
  final String title;
  final VoidCallback action;
  const DefaultButton(this.title, this.action, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
            color: Colors.purpleAccent,
            borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
