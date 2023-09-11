import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final IconData icon;
  final Color background;
  final String text;
  final Function action;

  const Button({super.key, required this.icon, required this.background, required this.text, required this.action});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      color: background,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          action();
        },
        child: Container(
          width: 300,
          height: 60,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}