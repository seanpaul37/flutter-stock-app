import 'package:flutter/material.dart';

class ValidateWidget extends StatelessWidget {
  const ValidateWidget({
    Key? key,
    required this.callback,
  }) : super(key: key);
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(20)),
        child: const Text(
          "Valider",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
