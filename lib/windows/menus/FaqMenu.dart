// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ProdcutFaq extends StatelessWidget {
  const ProdcutFaq({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Problème à propos des produits?",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 20),
            ),
          ],
        ),
        SizedBox(height: 20),
        CircularProgressIndicator()
      ],
    );
  }
}
