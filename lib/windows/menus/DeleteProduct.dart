// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../home/HomeScreen.dart';

class ProductsDeletes extends StatefulWidget {
  const ProductsDeletes({
    super.key,
  });

  @override
  State<ProductsDeletes> createState() => _ProductsDeletesState();
}

class _ProductsDeletesState extends State<ProductsDeletes> {
  int number = 10;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.7,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Liste des produits supprimés",
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w800,
                      fontSize: 20),
                ),
              ],
            ),
            // Icon(Icons.track_changes),
            ...List.generate(
                number,
                (index) => ListTile(
                      hoverColor: Colors.blueAccent,
                      leading: const Icon(
                        Icons.track_changes,
                        color: Colors.blue,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Supprimer définitivement 👉",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(
                                        builder: (BuildContext context,
                                            StateSetter state) {
                                          return AlertDialog(
                                            title: Container(
                                                padding:
                                                    const EdgeInsets.all(19),
                                                color: const Color(0xFF323E50),
                                                child: const Text(
                                                  "Suppression totale ?",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                            content: SizedBox(
                                              height: 80,
                                              width: 100,
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        number = number - 1;
                                                        HomeScreen.active
                                                            .value = false;
                                                        if (kDebugMode) {
                                                          print(HomeScreen
                                                              .active.value);
                                                          print(number);
                                                        }
                                                        Navigator.of(context)
                                                            .pop();
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 20,
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          "Supprimer",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          color: Colors.blue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 20,
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          "Annuler",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    });
                              },
                              icon: const Icon(
                                CupertinoIcons.trash_circle,
                                color: Colors.red,
                              )),
                        ],
                      ),
                      // Icon(
                      //   CupertinoIcons.trash_circle,
                      //   color: Colors.red,
                      //   semanticLabel: "Supprimer définitivement ?",
                      // ),
                      title: const Text("Boite à outil"),
                      subtitle: const Text("Supprimé le... 01/03/2024"),
                    ))
          ],
        ),
      ),
    );
  }
}
