// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/windows/security/SecurityScreen.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ProductSetting extends StatelessWidget {
  ProductSetting({
    super.key,
  });
  List<String> sentences = [
    "Dernière connexion",
    "Jour(s) d'absence(s)",
    "Mes actions",
  ];
  List<String> next = [
    // "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
    "${DateFormat('EEEE, d/M/y').format(DateTime.now())}",
    "2 Jour(s)",
    "Consulter",
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Paramètres",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 20)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Connecté en tant que : ",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
              Text(
                SecurityScreen.isAdmin.value
                    ? "Administrateur"
                    : "Gestionnaire",
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            padding: const EdgeInsets.all(40),
            decoration: const BoxDecoration(
                color: Colors.black45, shape: BoxShape.circle),
            child: const Icon(
              Icons.person,
              size: 50,
            ),
          ),
          const Text(
            "Vos différentes actions récentes en un points",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15),
          ),
          const Text(
            "👲🏿 👲🏿 👲🏿",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                3,
                (index) => Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withAlpha(50),
                            spreadRadius: 2,
                            blurRadius: 0.2,
                            offset: const Offset(0, 3)),
                      ]),
                  child: Column(
                    children: [
                      Text(
                        sentences[index],
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        next[index],
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: index == 0
                                ? Colors.black
                                : index == 1
                                    ? Colors.red
                                    : Colors.blue),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          ...List.generate(
              1,
              (index) => ListTile(
                    hoverColor: Colors.blueAccent,
                    leading: const Icon(
                      Icons.calendar_month,
                      color: Colors.blue,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "infos gestionnaire",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              CupertinoIcons.person_2_fill,
                              color: Colors.red,
                            )),
                      ],
                    ),
                    // Icon(
                    //   CupertinoIcons.trash_circle,
                    //   color: Colors.red,
                    //   semanticLabel: "Supprimer définitivement ?",
                    // ),
                    title: const Text("Signalement effectué"),
                    subtitle: const Text("Commande le... 01/03/2024"),
                  ))
        ],
      ),
    );
  }
}
