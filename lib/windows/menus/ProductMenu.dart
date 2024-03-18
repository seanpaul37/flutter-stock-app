// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:stock_app/core/services/ApiProvider.dart';

import '../../components/widgets/OngletWidget.dart';

class MenuSide extends StatefulWidget {
  const MenuSide({
    Key? key,
    required this.callback,
    required this.productList,
    required this.onChanged,
  }) : super(key: key);
  final VoidCallback callback;
  final dynamic productList;
  static ValueNotifier<bool> visible = ValueNotifier(true);
  static ValueNotifier<int> addOnglet = ValueNotifier(1);
  static ValueNotifier<int> onglets = ValueNotifier(0);
  final ValueChanged<String>? onChanged;

  @override
  State<MenuSide> createState() => _MenuSideState();
}

class _MenuSideState extends State<MenuSide> {
  List<String> productTitle = [
    "Produits",
    "Code",
    "Quantité",
    "Disponible",
    "Reservé",
    "Prix d'achat",
    "Prix de vente"
  ];

  List<dynamic> foundUser = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    foundUser = widget.productList;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: SizedBox(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 10),
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10))),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: const Text(
                      "Tout",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w800),
                    )),
                const SizedBox(width: 30),
                ...List.generate(
                  MenuSide.addOnglet.value,
                  growable: false,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        MenuSide.onglets.value = index;
                        if (kDebugMode) {
                          print("onglet == ${MenuSide.onglets.value}");
                        }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      decoration: const BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10))),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (MenuSide.addOnglet.value < 2) {
                                  MenuSide.addOnglet.value += 1;
                                } else {
                                  null;
                                }
                                if (kDebugMode) {
                                  print(MenuSide.addOnglet.value);
                                }
                              });
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 10,
                              child: Icon(Icons.add, size: 10),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            MenuSide.addOnglet.value > 1
                                ? "Nouvel onglet ${index + 1}"
                                : "Nouvel onglet",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (MenuSide.addOnglet.value > 1) {
                                  MenuSide.addOnglet.value =
                                      MenuSide.addOnglet.value - 1;
                                } else {
                                  null;
                                }
                                if (kDebugMode) {
                                  print(MenuSide.addOnglet.value);
                                }
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.red.shade600,
                              radius: 10,
                              child: const Icon(Icons.remove, size: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            const Divider(
                height: 5,
                color: Color.fromARGB(255, 72, 36, 34),
                thickness: 5),
            const SizedBox(height: 5),
            IndexedStack(index: MenuSide.onglets.value, children: [
              ...List.generate(MenuSide.onglets.value + 1, (index) {
                return OngletWidget(
                  callback: widget.callback,
                  size: size,
                  visible: MenuSide.visible,
                  productTitle: productTitle,
                  productList: widget.productList,
                  onChanged: widget.onChanged,
                );
              }),
            ])
          ]),
    ));
  }
}
