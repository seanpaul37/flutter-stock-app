// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stock_app/components/widgets/SettingSide.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: size.width,
      height: size.height * 0.1,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: const Color(0xFF323E50),
            child:
                const CircleAvatar(radius: 30, backgroundColor: Colors.white),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.only(left: 5, bottom: 5),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  // border: BorderDirectional(
                  //   start: BorderSide(color: Colors.white, width: 5),
                  //   end: BorderSide(color: Colors.white, width: 5),
                  //   bottom: BorderSide(color: Colors.white, width: 5),
                  // ),
                  color: Colors.red),
              child: const Text(
                "Gestion des Stocks",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
              )),
          Expanded(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    border: BorderDirectional(
                        start: BorderSide(color: Colors.white, width: 5),
                        end: BorderSide(color: Colors.white, width: 5),
                        bottom: BorderSide(color: Colors.white, width: 5)),
                    color: Colors.red),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(CupertinoIcons.car, color: Colors.white),
                    const SizedBox(width: 20),
                    const Expanded(
                      child: Text("Niveau de Stock",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800)),
                    ),
                    GestureDetector(
                        onTap: () {
                          SettingSide.indexPage.value = 6;
                          if (kDebugMode) {
                            print(SettingSide.indexPage.value);
                          }
                        },
                        child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.add))),
                    GestureDetector(
                        onTap: () {
                          SettingSide.indexPage.value = 7;
                          if (kDebugMode) {
                            print(SettingSide.indexPage.value);
                          }
                        },
                        child: Container(
                            margin: EdgeInsets.only(left: 20),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 3),
                              color: Colors.black54,
                            ),
                            child: const Row(
                              children: [
                                Text(
                                  "Sortie d'article",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Icon(
                                  Icons.exit_to_app_rounded,
                                  color: Colors.red,
                                )
                              ],
                            )))
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
