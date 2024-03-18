// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../windows/security/SecurityScreen.dart';

class DetailSide extends StatelessWidget {
  const DetailSide({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.9,
      width: size.width * 0.16,
      // padding: const EdgeInsets.symmetric(horizontal: 20),
      color: const Color(0xFF323E50),
      child: Column(
        children: [
          const Text(
            "Section",
            style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dashed),
          ),
          const SizedBox(height: 16),
          Text(
            SecurityScreen.isAdmin.value ? "Admin" : "Gestionnaire",
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
